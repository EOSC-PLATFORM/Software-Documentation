# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0 -- >

## How to build

The EOSC Messaging Service is comprised by three main components.

1) The **Messaging** service that is responsible for providing the core functionality by giving access to the primitives
   of a messaging service.
2) The **Authentication** service that allows users to authenticate by providing different credentials depending on
   their set-up.
3) The **Push server** that is responsible for delivering messages to remote destinations for push enabled flows.

All of the above services are represented by a single binary file after their build is completed.
Instructions on how to build each one of the services can be found in the following links.

- [Messaging Service](https://github.com/ARGOeu/argo-messaging/blob/master/README.md)
- [Authentication Service](https://github.com/ARGOeu/argo-api-authn/blob/master/README.md)
- [Push Server](https://github.com/ARGOeu/ams-push-server/blob/master/README.md)