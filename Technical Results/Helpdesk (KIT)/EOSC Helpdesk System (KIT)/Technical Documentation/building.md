# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >

## How to build

To build the EOSC Helpdesk, after installation of the Zammad instance the following additional packages (https://gitlab.eudat.eu/helpdesk/helpdesk-extentions) should be installed in helpdesk via admin interface: 

**Customizations:**

* The package implements multiportals functionality 

**DisableEditPersonalData**

* The package prevents editing of user personal data by the agents

**Form**

* The package enables custom web forms and their association with multiple groups 

**GGUS**

* Provides integration with GGUS 

**GroupSubscription**

* The package enables multiple group subscription to the ticket

**MiniAdmin**

* The package enables delegation of some admin functions to the powered agents of the dedicated support areas, the functionality used in multiportals implementation

**NoSplitNotify**

* The package disables notification on ticket splitting to the customer 

**ProfilePermissions**

* The package enables permissions table for the agents available in profile view

After installing, updating, or uninstalling packages the following commands need to be executed on the server:

* _root> zammad config:set BUNDLE_DEPLOYMENT=0_
* _root> zammad run bundle config set --local deployment 'false'_
* _root> zammad run bundle install_
* _root> zammad run rake zammad:package:migrate_
* _root> zammad run rake assets:precompile_
* _root> systemctl restart zammad_

**Important**: For each update of the helpdesk system all packages have to be tested on the test instance and new versions of the packages have to be installed with updated Zammad software. 
