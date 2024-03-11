# Licence

<! --- SPDX-License-Identifier: CC-BY-4.0  -- >

## Security

The EOSC Helpdesk has implemented various measures to ensure secure communication and minimize the risk of personal data leakage. The Helpdesk software based on Zammad enables: 
* Email ecryption based on S/MIME for high-security email communication. The encryption and signing for outgoing emails can be turned on by using "Encrypt" and "Sign" buttons. 
* Password policies (For EOSC Helpdesk relevant for admin access to the service). 
* Token access for third-party applications to use the Zammad API.
* List of connected devices used by user with possibility to revoke access at any time. 
* Notification to any helpdesk user when logged from unsual place. 

The agents of the EOSC Helpdesk have access to the private data of all the users, but they can't modify any data ( Name, Surname, voPersonID, email). The standard TLS layer provides secure communication for the users over the internet. 

The EOSC Helpdesk is running in secure environment in HA virtual ESX cluster at KIT, which is being monitored by security authorities of DFN ( German Organization for Information Security for Science and Research). The Helpdesk database is backed up  twice a day, in addition the a snapshot of the virtual instance is created once a day. 