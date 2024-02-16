# Nearest Neighbor Finder (version 1.4.2) for EOSC Online ML Engine

> The objective of this module is to provide a search endpoint for the nearest neighbor index. Version of indexes: `1.4.2`.

## Development utils

- **[pre-commit](https://pre-commit.com/)**
- **[black](https://github.com/psf/black)**
- **[flake8](https://github.com/pycqa/flake8)**
- **[pylint](https://github.com/PyCQA/pylint)**
- **[google docstrings](https://google.github.io/styleguide/pyguide.html#38-comments-and-docstrings)**

## Requirements and dependencies

- **Docker**
  - [docker-compose](https://docs.docker.com/compose/install/)
- **Python 3.8**
  - Packages listed out in [requirements.txt](requirements.txt) will be installed when building docker image
- **HDFS** containing the following data:
  - indexer files containing indexes trained with INDEX_TAG=1.4.2, stored under path `user/{HDFS_USER}/nn-finder/{INDEX_TAG}`
  - graph connection dictionaries 'direct_connections.map.json.zst' and 'direct_connections.int.json.zst' stored under path indicated by `GRAPH_HDFS_PATH`
- **Downloader** service, preferrably deployed on a separate server, or locally (see [docker-compose.yml](docker-compose.yml)), with volume **app/indexers** shared between Downloader and main NN Finder API
- **Training Module** which creates the necessary indexes that the NN Finder operates on. It is separately described in its own [repository](https://git.man.poznan.pl/stash/projects/EOSC-RS/repos/nearest-neighbor-finder/browse)

- Optional: if index training is performed using this module in case the Nearest Neighbor Finder Training Module is unavailable, **PostgreSQL** tables are needed in the same configuration as described in README of NN Finder Training Module

### Install dependencies

The dependencies are installed automatically in the `docker-compose build` command. You can add dependencies by modifying the `requirements.txt` file, or use `poetry` and export the file automatically:

1. poetry add `package_name`
2. Execute the following command: `poetry install --dev`
3. Export the new set of packages to requirements file by executing `poetry export --without-hashes -f requirements.txt --output requirements.txt`

## Endpoints

### Grap search
The **/search_graph/** endpoint returns neighbors of the provided node of a graph, which are the nodes adjacent to the context node provided in request body. The graph for searching is loaded from HDFS on app startup. The input is a `context_resources` list of strings, with each string containing the id of node. Example request body:

```json
[
  "50|dedup_wf_001::46ac36dafa82041e3bb065e4878d4617",
  "50|doi_dedup___::73210f281dde82edfe3304ada044dbd5"
]
```

### Index search
The **/search/{table}/{qtype}/** endpoint in its simplest form takes the context items of a specified table, the type of search we want to use based on the qtype value of 'emb' or 'id' , and the required parameterk k standing for the number of neighbors we want to find for every context item provided.

Context data is passed in the request body JSON. In case of `id` request, the "id" value contains a list of database ID strings for each context item. In `emb` requests, the "emb" value is a string containing a 2D array of embeddings using floating-point values, where rows correspond to the items. Example body JSON:

```json
{
  "emb": "[[0.1, 0.2, ...], [0.55, ...], ...]" or None,
  "id": ["id1", "id2", ...] or None
}
```

The example embeddings can be found in `test/example_context_embeddings.txt`, and an example request can be found below in this README document. The returned search result is a list of lists, each consisting of K+1 most similar items to the one provided in the search context list. Results are returned as IDs, but setting the get_embs flag to True also returns a lists of embeddings for the results. The 1 additional result stems from the fact that if we search by an item that is present in the dataset, it gets returned as well.

The trim_first flag allows us to remove the first result when using embeddings of items already existing in the database. In case there are multiple results with distance to context item equal to 0 no results are trimmed, which ensures that a newly found item that is alike is not trimmed. In case of `id` search, if the ID of resource provided in context was not found in the index, the search is not performed on it and it is removed from the result.

### Index loading
The tables in `INIT_TABLES` are loaded automatically on startup. The user indexes, dynamically trained by NN Finder Training Module, are specified in `DYNAMIC_TABLES` and loaded to NN Finder every `DYNAMIC_LOADING_INTERVAL` minutes.

The **/update_index** and **/load_index** endpoints load the listed pre-trained Indexes stored in HDFS to app memory in two steps. First, a list of table names of which new indexes will be loaded are passed to the downloader's endpoint **/download_index**, so that the separate service downloads indexes from HDFS to local shared volume, in parallel to the API still working on the previous indexes. The indexes will be downloaded in parallel to the main API running, and then the downloader calls **/load_index** endpoint on the main API, so that the indexes are loaded to working memory.
There is an option to instead load indexes directly from HDFS, by using the parameter `force_direct_update` in **/update_index** request, or setting `USE_DOWNLOADER` globally, which will also load startup and dynamic indexes directly.

Example request:
`http://localhost:8000/update_index/?tables=["trainings", "services"]`

Another provided endpoint is **/train/{table}**, which creates and trains a new index for selected embedding dataset. This operation should be performed by the separate app `Nearest Neighbor Finder Training Module`, so the endpoint is turned off by default with `ALLOW_TRAINING` set to False.

Example request:
`http://localhost:8000/train/?table=services&load_to_memory=true`

### Diagnostics
The endpoint **/diag** is used to check the state of the API. If the app is running properly, this endpoint should return a `200` response with a `status="UP"` a list of indexes currently loaded into memory, as well as states of modules that the application depends on. In the case of NN-Finder it is PostgreSQL and HDFS. If the module responds successfully, the resources located in it are listed out in the endpoint response. PostgreSQL lists out tables available for training, while HDFS returns the names of each index available for loading into memory.

Example request:
`http://localhost:8000/diag/`

## Run example

1. Add required .env file in the project directory
2. Create pod for volume "indexers" shared between main API and downloader services
3. Build docker image with `docker compose build`
4. Run command `docker compose up`to start the fastapi instance in the created container
5. Navigate to the [http://localhost:8000/docs](http://localhost:8000/docs)
6. Run **/search** specifying the table name, context items for search in the form of a table of embeddings or ids, the format of providing context items by value `emb` or `id`, and set the number of K recommendations you want to be served for each context item provided in 'data'. In case of last three user indexes, you have to also provide the type of action as well as resource, as there is a separate index for each configuration of user_type x user_action x resource. The allowed values for all of the parameters are listed below.

Example `emb` request:

```bash
curl -X 'POST' \
  'http://localhost:8000/search/services/emb/?k=4&trim_first=false&get_embs=false' \
  -H 'accept: application/json' \
  -H 'Content-Type: application/json' \
  -d '{
  "emb": "[[-0.4206928610801697, 0.07516717910766602, -0.9969730973243713, -0.7159566283226013, 0.13657799363136292, 0.4238385856151581, -0.23220255970954895, 0.15399323403835297, 0.04464587941765785, 0.9670936465263367, 0.12440324574708939, 0.9635890126228333, -0.9944945573806763, -0.9078701138496399, -0.9996107220649719, -0.2731923460960388, 0.9541007876396179, -0.9860572218894958, 0.8703622221946716, -0.9822844862937927, -0.9996826648712158, 0.9995790123939514, 0.9933595657348633, 0.019947322085499763, 0.911224901676178, 0.7171142101287842, -0.11694595962762833, 0.46149834990501404, 0.9999403357505798, -0.19033724069595337, -0.8788314461708069, -0.11707092076539993, -0.2164987027645111, -0.8948861956596375, -0.9871098399162292, -0.5092473030090332, -0.31157389283180237, 0.9924110770225525, 0.8458080887794495, 0.2560126483440399, 0.9893143177032471, -0.36435943841934204, -0.30564284324645996, 0.359933465719223, 0.991787314414978, 0.27461233735084534, 0.5598061084747314, 0.9983577132225037, 0.34936589002609253, -0.10975416749715805, -0.4919663071632385, 0.12597788870334625, -0.0046684215776622295, 0.9933499097824097, -0.6482734680175781, 0.6350980401039124, 0.6754872798919678, 0.9301472306251526, -0.07753627747297287, -0.024211836978793144, -0.9992541074752808, 0.9835981726646423, 0.5109623074531555, 0.9778566360473633, 0.36632707715034485, -0.9673861265182495, 0.33339470624923706, -0.5315327048301697, -0.5043314099311829, 0.09081028401851654, -0.09034629911184311, 0.22475485503673553, 0.964819073677063, 0.4685038924217224, -0.9528782963752747, -0.9732711315155029, -0.3500433564186096, -0.6908408403396606, 0.08475269377231598, 0.982275664806366, 0.7212560772895813, 0.09441449493169785, -0.5327246189117432, -0.12328271567821503, -0.11435043811798096, -0.13647182285785675, -0.2774674594402313, 0.9967450499534607, -0.8404017090797424, -0.9690729379653931, 0.9171442985534668, -0.9949521422386169, -0.3977108597755432, -0.242024764418602, -0.7900366187095642, -0.04828344285488129, -0.27394646406173706, -0.762657105922699, 0.08127187192440033, 0.2956477701663971, -0.8653119206428528, -0.9258632659912109, -0.5118086934089661, 0.5554863214492798, 0.5911867022514343, 0.03630509972572327, -0.9910299181938171, -0.6703535318374634, -0.09274275600910187, 0.04502198100090027, -0.05712904781103134, -0.15176156163215637, -0.13073495030403137, 0.029901817440986633, 0.1528734266757965, -0.16491630673408508, 0.11190404742956161, -0.998799204826355, -0.9966844916343689, 0.0948779359459877, -0.9977127313613892, -0.9996456503868103, -0.3294309377670288, -0.7898949980735779, 0.8964288234710693, 0.018887914717197418, -0.9940612316131592, 0.6878424286842346, 0.02782128006219864, -0.9994874000549316, 0.008954587392508984, -0.2269265055656433, -0.005239200312644243, -0.9898927211761475, -0.3524905741214752, -0.3175952434539795, -0.7447274327278137, 0.9890157580375671, -0.7798953056335449, 0.08326736092567444, 0.5364648699760437, -0.12512265145778656, -0.9796302318572998, 0.9994556903839111, 0.4944361746311188, -0.9778629541397095, -0.9750434160232544, 0.9979042410850525, 0.9999113082885742, -0.6243958473205566, 0.9975689649581909, -0.986714243888855, -0.9960397481918335, 0.42941680550575256, 0.9568762183189392, 0.016625314950942993, 0.6216799020767212, 0.144889235496521, 0.9992945194244385, 0.037743788212537766, -0.9937310218811035, -0.6231953501701355, -0.2550525665283203, -0.7904553413391113, -0.9837384819984436, -0.9854026436805725, -0.1258881539106369, 0.8797341585159302, -0.9804496765136719, 0.05931854248046875, 0.3773936629295349, 0.9292963147163391, 0.28055599331855774, -0.14798276126384735, -0.1239599660038948, -0.30417370796203613, 0.5314726233482361, -0.5518438220024109, 0.02630951814353466, -0.05826932564377785, -0.2732435166835785, 0.2873474359512329, -0.3377699851989746, -0.9989814758300781, 0.9849104881286621, -0.768260657787323, 0.9499835968017578, 0.998692512512207, 0.08864492923021317, 0.9073078036308289, -0.08959142118692398, 0.9594030380249023, 0.7980218529701233, -0.9160665273666382, -0.17410330474376678, 0.9961295127868652, -0.36888736486434937, 0.5421361327171326, -0.9439945816993713, 0.1027565523982048, 0.35259243845939636, -0.9632030725479126, -0.4004136621952057, 0.9998338222503662, 0.8786514401435852, 0.8872038722038269, -0.5089784860610962, -0.372749924659729, -0.4013742506504059, 0.9904745221138, 0.3576478958129883, 0.7426918745040894, 0.7836437225341797, 0.86939936876297, -0.9990077018737793, -0.20875337719917297, 0.9876749515533447, -0.9071556329727173, 0.2725008726119995, 0.9985469579696655, -0.7270413637161255, -0.9462600946426392, -0.9971451163291931, -0.410382479429245, 0.9996239542961121, 0.7816243767738342, -0.3549560010433197, -0.057166825979948044, 0.9963685274124146, -0.029203185811638832, 0.9934456944465637, 0.4890706539154053, 0.9714606404304504, 0.990985095500946, -0.9908553957939148, -0.14153802394866943, 0.8346111178398132, 0.0016051982529461384, -0.14119918644428253, -0.25810131430625916, 0.9545291066169739, 0.9365748167037964, -0.9662489891052246, 0.08302959054708481, 0.9997358918190002, 0.9989893436431885, -0.27319806814193726, -0.15876226127147675, -0.7768677473068237, -0.9362571239471436, -0.26599064469337463, 0.9661158919334412, -0.9973108172416687, -0.008351837284862995, 0.9839401245117188, -0.7346374988555908], [-0.4383462071418762, 0.1649363487958908, -0.9871393442153931, -0.549798309803009, 0.13601963222026825, 0.33134737610816956, -0.249564066529274, 0.11095448583364487, 0.04624474048614502, 0.9637287259101868, 0.2730322480201721, 0.9477397203445435, -0.9984350800514221, -0.9739697575569153, -0.9937208890914917, -0.03968435153365135, 0.9729716777801514, -0.9911091923713684, 0.9757047295570374, -0.9651879072189331, -0.9998471140861511, 0.9928267598152161, 0.991567850112915, 0.6257542371749878, 0.9765768647193909, 0.7257003784179688, -0.10539379715919495, 0.5669794082641602, 0.9998332858085632, -0.18062451481819153, -0.9746443033218384, -0.014375424943864346, 0.8926711082458496, -0.8927611708641052, -0.974726140499115, -0.5929989814758301, -0.304717093706131, 0.9954679012298584, 0.9260071516036987, 0.4195411205291748, 0.9802117943763733, -0.8364678621292114, -0.10014553368091583, -0.0018224696395918727, 0.9953847527503967, 0.09890449047088623, 0.816538393497467, 0.9946306347846985, 0.23531442880630493, -0.13156326115131378, -0.4182013273239136, 0.030762717127799988, 0.03359619900584221, 0.9832326173782349, -0.7485737204551697, 0.1549728661775589, 0.12350170314311981, 0.8530149459838867, -0.16652530431747437, -0.8169867992401123, -0.9978081583976746, 0.9870829582214355, 0.22443696856498718, 0.9416072368621826, 0.14496204257011414, -0.9346826076507568, 0.2601815164089203, -0.6217718124389648, -0.6058899760246277, 0.2314135879278183, -0.061740826815366745, 0.1523301899433136, 0.88520348072052, 0.0908936858177185, -0.4102560877799988, -0.8901627659797668, 0.6079835891723633, -0.6057692766189575, 0.5314307808876038, 0.9349629878997803, 0.6974367499351501, 0.16572630405426025, -0.5339885354042053, -0.21284928917884827, -0.06238393485546112, -0.3557341694831848, -0.11453155428171158, 0.9652262330055237, -0.9478420615196228, -0.90357506275177, 0.9227877259254456, -0.9905074834823608, 0.4498853385448456, -0.12606802582740784, -0.6228064894676208, -0.36526548862457275, -0.09902341663837433, -0.15307588875293732, -0.3858548402786255, 0.31271854043006897, -0.7412617206573486, -0.9835087656974792, -0.046041302382946014, 0.5481051206588745, 0.40199920535087585, 0.03834903985261917, -0.9594661593437195, -0.45379137992858887, 0.08709590137004852, 0.11917446553707123, 0.006477332208305597, -0.015292765572667122, 0.049680616706609726, 0.09673500806093216, -0.03820829465985298, -0.06860606372356415, 0.8841659426689148, -0.9991223216056824, -0.9155811071395874, 0.24353575706481934, -0.9823102355003357, -0.9991782307624817, -0.3117578327655792, -0.9753936529159546, 0.8478712439537048, 0.09336521476507187, -0.9990138411521912, 0.8122057318687439, -0.12324272841215134, -0.9922125935554504, -0.10043253749608994, 0.07530152052640915, 0.10577144473791122, -0.9442141652107239, -0.3050187826156616, -0.30260995030403137, -0.8077192306518555, 0.978731632232666, -0.8091603517532349, 0.04391903057694435, -0.27401241660118103, -0.11866937577724457, -0.986942708492279, 0.9926702380180359, 0.1418462097644806, -0.9340239763259888, -0.9154532551765442, 0.9918705821037292, 0.9998167753219604, -0.047466941177845, 0.9725182056427002, -0.8454460501670837, -0.9613714218139648, 0.4314592182636261, 0.8308571577072144, 0.03361804410815239, 0.732329785823822, 0.12256550043821335, 0.991507887840271, -0.287647545337677, -0.9676464200019836, -0.752930760383606, -0.8599667549133301, -0.7072116136550903, -0.9115665555000305, -0.9917241334915161, -0.20866873860359192, 0.4265880286693573, -0.9878236651420593, 0.06507590413093567, -0.29876354336738586, 0.3634171783924103, -0.6741481423377991, 0.035350024700164795, 0.08912664651870728, -0.12381764501333237, -0.12242099642753601, -0.7613985538482666, -0.05827165022492409, -0.07328526675701141, -0.6277716755867004, 0.32143786549568176, -0.31368938088417053, -0.9850782155990601, 0.9388923645019531, -0.8884749412536621, 0.8639551997184753, 0.9988243579864502, -0.035562243312597275, 0.6446789503097534, -0.0874381810426712, 0.8561142683029175, 0.7715780735015869, -0.8021690249443054, -0.29130780696868896, 0.9638557434082031, -0.2633606791496277, 0.45165422558784485, -0.9626453518867493, -0.03309043496847153, 0.6116899251937866, -0.2961823046207428, -0.5625263452529907, 0.9997465014457703, 0.7926732301712036, 0.9927076101303101, 0.062054093927145004, -0.041841018944978714, 0.04286542162299156, 0.9968019723892212, 0.9525299668312073, 0.7738626599311829, 0.7492901086807251, 0.5295478105545044, -0.9985846281051636, -0.10066568106412888, 0.9414724707603455, -0.9842014312744141, -0.3059265613555908, 0.9925487041473389, 0.1694726198911667, -0.9842345714569092, -0.9952756762504578, -0.35393428802490234, 0.999224841594696, 0.4266754984855652, 0.47458598017692566, -0.05478498712182045, 0.9604316353797913, -0.15541914105415344, 0.9987460374832153, 0.66108238697052, 0.6369034051895142, 0.9818547368049622, -0.9977841973304749, -0.0018722707172855735, 0.8151308298110962, -0.06337011605501175, -0.07908736169338226, -0.07623939216136932, 0.8902726769447327, 0.8320024609565735, -0.8849532008171082, 0.07855402678251266, 0.9994876980781555, 0.9937388896942139, -0.3891383707523346, -0.07011202722787857, -0.8593891263008118, -0.908081591129303, -0.2954021096229553, 0.9465640187263489, -0.9969860315322876, -0.18029695749282837, 0.9527067542076111, -0.8265790939331055], [-0.29608792066574097, -0.012140879407525063, -0.9967048764228821, -0.7781224250793457, -0.052426133304834366, 0.8025038838386536, -0.1792958676815033, 0.06781239807605743, -0.12821228802204132, 0.7059110403060913, 0.2343641072511673, 0.9259920716285706, -0.9989508986473083, -0.8873897194862366, -0.9833452105522156, 0.0005107710021547973, 0.991179347038269, -0.5150142908096313, 0.9935868382453918, -0.9975820183753967, -0.9999461770057678, 0.9869629740715027, 0.9982511401176453, -0.6699231266975403, 0.9336526393890381, 0.4904944598674774, -0.1551804542541504, 0.43512746691703796, 0.9995132684707642, -0.1116342768073082, -0.9442929625511169, -0.03522235527634621, 0.9768566489219666, -0.7261236906051636, -0.9779355525970459, -0.8110161423683167, -0.18005669116973877, 0.9704198241233826, -0.7869952321052551, 0.33842936158180237, 0.9660316109657288, -0.9141445159912109, -0.13303039968013763, -0.609961986541748, 0.7763205170631409, 0.060047831386327744, 0.6996726393699646, 0.9579555988311768, 0.22680102288722992, -0.20857520401477814, -0.7429672479629517, -0.6246037483215332, 0.07731813937425613, 0.9956929683685303, -0.8709777593612671, -0.1367141306400299, 0.9676565527915955, 0.9733609557151794, -0.16329778730869293, 0.32153791189193726, -0.9950757026672363, 0.9557527899742126, 0.9383071660995483, 0.9733758568763733, 0.5399550795555115, -0.9653749465942383, 0.3322269320487976, -0.8882229328155518, -0.5458987951278687, 0.21007171273231506, -0.019197387620806694, 0.19816559553146362, 0.9080579876899719, -0.41047224402427673, -0.9907327890396118, -0.8967322111129761, 0.9958091974258423, -0.15758244693279266, 0.6434533596038818, 0.5702469944953918, 0.7208918333053589, 0.17573288083076477, -0.3211032748222351, -0.08754761517047882, -0.10881562530994415, -0.726806104183197, -0.16942544281482697, 0.9817380905151367, -0.9764894843101501, -0.9390718340873718, 0.8791985511779785, -0.9436839818954468, 0.5887997150421143, -0.07896394282579422, -0.9729200005531311, -0.9020804762840271, 0.029755638912320137, -0.3234187364578247, -0.6435121297836304, 0.39778682589530945, -0.6229491829872131, -0.9897596836090088, -0.8477954268455505, 0.9326890110969543, -0.29086625576019287, 0.013937253504991531, -0.9876476526260376, -0.9453209042549133, 0.10847637057304382, 0.060558803379535675, -0.1848391741514206, -0.01710168458521366, 0.12115584313869476, -0.09755183011293411, 0.11013339459896088, -0.1381838023662567, 0.8825365900993347, -0.99090975522995, -0.9877483248710632, 0.08952240645885468, -0.998663067817688, -0.9910891652107239, -0.26812034845352173, -0.9370205402374268, 0.3834894895553589, 0.140608012676239, -0.9948687553405762, -0.7123963236808777, -0.0526384599506855, -0.986254096031189, -0.25029560923576355, 0.18240413069725037, 0.09888625144958496, -0.8958497643470764, -0.42599883675575256, -0.8062954545021057, -0.9711965918540955, 0.5407719612121582, -0.9077818393707275, 0.09028647840023041, 0.7447932958602905, -0.04179786518216133, 0.1441107988357544, 0.9769655466079712, 0.8685675859451294, -0.8439033627510071, -0.9725903272628784, 0.9994091987609863, 0.9988114833831787, -0.2952020466327667, 0.9918186664581299, -0.7012741565704346, -0.9893320798873901, 0.21833981573581696, 0.761335551738739, -0.07317429780960083, 0.8304163217544556, 0.16722702980041504, 0.9707297086715698, 0.23883436620235443, -0.9931799173355103, -0.8914293050765991, 0.6867232322692871, -0.9730149507522583, -0.7263087630271912, -0.9971279501914978, -0.03180132806301117, 0.55962735414505, -0.9845190644264221, -0.004807755351066589, -0.39287176728248596, 0.9984843730926514, -0.746191680431366, -0.11093536764383316, 0.11519583314657211, -0.09433189034461975, 0.9269810318946838, 0.8282142877578735, -0.07601864635944366, -0.010790599510073662, -0.955084502696991, 0.070236936211586, 0.015765393152832985, -0.9920012354850769, 0.9870995283126831, 0.4828539788722992, 0.9603636264801025, 0.9992085099220276, 0.13686871528625488, 0.9977912902832031, -0.10201022028923035, 0.9690349102020264, 0.9017975330352783, -0.994525134563446, -0.4713517129421234, 0.9903362393379211, -0.06078711152076721, 0.441572904586792, -0.7837249636650085, -0.15054860711097717, 0.6683548092842102, -0.9596509337425232, 0.8403213024139404, 0.9996945261955261, 0.9912565350532532, 0.866970956325531, 0.9852439165115356, -0.7277794480323792, -0.9688979387283325, 0.9830527901649475, -0.7536162734031677, 0.9812779426574707, 0.7666528224945068, 0.9428932666778564, -0.9989883303642273, -0.19431737065315247, 0.9869283437728882, -0.998085618019104, 0.5130179524421692, 0.9938609004020691, 0.4359249472618103, -0.9881511330604553, -0.9597421288490295, -0.21544750034809113, 0.9993441700935364, 0.9625550508499146, 0.22065575420856476, 0.04811365529894829, 0.9884624481201172, -0.09971501678228378, 0.9978097677230835, 0.7572365999221802, 0.9882261753082275, 0.9880574345588684, -0.9921455383300781, -0.09217941761016846, 0.801663339138031, -0.21134625375270844, -0.21929098665714264, -0.06788377463817596, 0.6919201612472534, 0.9888753890991211, -0.9660817384719849, -0.06330279260873795, 0.9977249503135681, 0.9994786977767944, -0.9495345950126648, 0.0687561184167862, -0.7341552972793579, -0.9729105830192566, -0.21051017940044403, 0.9822942614555359, -0.8653534054756165, -0.12171266227960587, 0.983009397983551, -0.9670603275299072]]",
  "id": [
    "string"
  ]
}'
```

Example `id` request:

```bash
curl -X 'POST' \
  'http://localhost:8000/search/services/id/?k=4&trim_first=false&get_embs=false' \
  -H 'accept: application/json' \
  -H 'Content-Type: application/json' \
  -d '{
  "id": [
    "47"
  ]
}'
```

1. In case of changes in the embedding dataset, use the Nearest Neighbor Finder Training Module. Users tables are dynamically trained (every 30 minutes by default) and loaded by this module. If the Training Module is not available, you can set the variable `ALLOW_TRAINING` to True, and use this module's **/train** endpoint with the **load_to_memory** parameter.

## Search endpoint index-specific parameters

|Parameter|Possible values|
|---|---|
| table_name | 'datasets', 'publications', 'software', 'other_research_product', 'services', 'trainings', 'data_sources', 'data_sources', 'users', 'users_anon', 'users_aai' |
| data_source | 'pg', 'hdfs' |
|---|---|
| Required only when training a user index |
| user_resource | 'datasets', 'publications', 'services', 'software', 'trainings', 'other_research_product', 'data_sources' |
| user_action | 'visited', 'ordered' |
||

### Error status codes

|Error code|Title|Description|
|---|---|---|
|API errors|
| 701| Table not found | There is no table present in the database with the name provided. |
| 702| Invalid query type | The provided qtype keyword is not a viable query type. |
| 703| ID data parsing error | ID context data should be a list of strings. |
| 704| EMB data parsing error | EMB context data should be a string containing a list of embeddings, formatted as lists of floating point numbers. |
| 705| Invalid K value | K value should be an integer between 1 and 128. |
| 706 |Invalid user parameters |When operating on a users index, user_resource and user_action parameters must be specified. See README for possible values. |
|707 |Invalid data source for an users table |User indexes are trained exclusively with data from postgresql - change data_source parameter value to "pg" |
|Index errors|
| 721| Index could not be created | The KNN index creation failed. |
| 722| Index could not be trained | The KNN index training failed. |
| 723| Index not present | The KNN index you are trying to use is not present in the database. |
| 724| Index not trained | The KNN index you are trying to use has not been trained yet. |
| 725| Recommendation unsuccessful | The KNN index has failed to retrieve recommendation results. |
| 726| Not enough valid resources | Too many rows in source table were tagged as invalid, so the index cannot be created. |
| |
|Mapping errors|
| 731| ID mapping creation failed | ID mapping creation failed |
| 732| IID-SID mapping failed | Index IDs could not be mapped to Source IDs with the currently saved mapping file. |
| 733| SID-IID mapping failed | Source IDs could not be mapped to Index IDs with the currently saved mapping file. |
| |
|Connection errors|
| 741| Database connection error | An error occured while fetching a database result. |
| |

### Enviroment variables

|Variable name|Description|
|---|---|
| PROJECT_NAME | "Nearest Neighbor Finder" |
| LOGGING_LEVEL | Level of how descriptive the logs are, default value is "WARNING" |
| MAX_N_INDEXERS | Maximum number of versions of a single indexer stored in HDFS |
| INDEX_TAG | Specifies the subdirectory in which the trained indexes are stored, default corresponds to the Training Module version |
| TABLES_CONFIG_PATH | Specifies the directory of locally stored JSON file with tables data needed for proper functioning of the module |
| INIT_TABLES | List of indexes that will be loaded from HDFS on startup, defalut is a list of all available tables |
| DYNAMIC_TABLES | List of table types of user indexes that will be loaded cyclically, default is a list of all available user tables |
| DYNAMIC_LOADING_INTERVAL | Time between dynamic loading runs of user tables in minutes, 30 by default. |
| STARTUP_WAIT_TIME | The time that the API module will wait on startup for the downloader service to download all HDFS files to local disk space |
| REMOVE_ZEROED_USERS | Flag indicating whether the users should be removed from indexes when their embeddings are zeroed out. Default is True |
| REMOVE_ZEROED_RESOURCES | Flag indicating whether the resources should be removed from indexes when their embeddings are zeroed out. Default is False |
| REMOVE_INVALID_RESOURCES | Flag indicating whether the resources should be removed from indexes when their embeddings are zeroed out. Default is True |
| REMOVE_FOREIGN_RESOURCES | Flag indicating whether the resources should be removed from indexes when their language is not RESOURCE_LANGUAGE. Default is True |
| RESOURCE_LANGUAGES | List of languages of the resources that should be kept in the index. Default is ["en"].|
| ALLOW_TRAINING | Flag that turns on and off the /train endpoint in this module. Default is False |
| USE_DOWNLOADER | Flag that sets whether API loads indexes from shared volume or directly from HDFS. Default is True |
| DOWNLOADER_URL | The url of index downloading service, used by fastapi |
| FASTAPI_URL | The url of the main fastapi service, used by downloader |
| POSTGRES_HOST | URL to the PostgreSQL connection |
| POSTGRES_DATABASE | Database name for the PostgreSQL connection |
| POSTGRES_USER | Username for the PostgreSQL connection |
| POSTGRES_PASSWORD | Password for the PostgreSQL connection |
| HDFS_URL | URL for the HDFS connection |
| HDFS_USER | Username for the HDFS connection, `hadoop` by default |
| HDFS_TIMEOUT | Integer indicating the time for hdfs connection timeout in seconds, default is 60 |
| POSTGRES_TIMEOUT | Integer indicating the time for PostgreSQL connection timeout in seconds |
| GRAPH_DOWNLOAD | Flag that indicates whether the indexes should be downloaded on startup from HDFS. Default is True |
||

## Error status codes

|Error code|Title|Description|
|---|---|---|
| API errors |
| 700| Something went wrong | General exceptions, see logs for more details. |
| 701| Table not found | There is no table present in the database with the name provided. |
| 702| Invalid query type | The provided qtype keyword is not a viable query type. |
| 703| ID data parsing error | ID context data should be a non-empty list of strings. |
| 704| EMB data parsing error | EMB context data should be a non-empty string containing a list of embeddings formatted as lists of floating point numbers. |
| 705| Invalid K value | K value should be an integer between 1 and 128. |
| 706 |Invalid user parameters |When operating on a users index, user_resource and user_action parameters must be specified. See README for possible values. |
|707 |Context data missing | Context data provided for the selected query type is missing in the request body. |
| |
| Index errors |
| 721| Index could not be created | The KNN index creation failed. |
| 722| Index could not be trained | The KNN index training failed. |
| 723| Index not present | The KNN index you are trying to use is not present in the database. |
| 724| Index not trained | The KNN index you are trying to use has not been trained yet. |
| 725| Recommendation unsuccessful | The KNN index has failed to retrieve recommendation results. |
| 726| Not enough valid resources | Too many rows in source table were tagged as invalid, so the index cannot be created. |
| 727| Graph not present | Graph was not loaded to memory. |
| 728| Graph search failed | None of the requested IDs could be found in the graph. |
| |
| Mapping errors |
| 731| ID mapping creation failed | ID mapping creation failed |
| 732| IID-SID mapping failed | Index IDs could not be mapped to Source IDs with the currently saved mapping file. |
| 733| SID-IID mapping failed | Source IDs could not be mapped to Index IDs with the currently saved mapping file. |
| |
| Connection errors |
| 741| Database connection error | An error occured while fetching a database result. |
| |

### Running Tests

To run tests:

Prerequisites: **Python 3.8** and an **NN Finder instance running on localhost**
1. create a virtual environment: `virtualenv --python=/usr/bin/python3.8 venv` (or provide other location of your python installation)
2. in `venv/lib/python3.8/site-packages/` add file `path.pth` containing full paths to folders `/app` and `/test`
3. run the virtual environment: `source venv/bin/activate`
4. move to the folder containing tests: `cd test`
5. install all required packages: `pip install -r test_requirements.txt`
6. create an `.env` file (in `/test`) with all necessary variables (described in documentation) and add the following:

```bash
FASTAPI_URL=http://localhost:8000
INIT_TABLES=["services", "users"]
DYNAMIC_TABLES=[]
ALLOW_TRAINING=True
USE_DOWNLOADER=False
TABLES_CONFIG_PATH=./app/test_tables_config.json
SHARED_VOLUME_PATH=./app/indexers/
INDEX_TAG=1.4.2
DOWNLOAD_WAIT_TIME=1
```

7. run `coverage run -m pytest test_main.py --log-cli-level=INFO`
8. run `coverage report -m`
