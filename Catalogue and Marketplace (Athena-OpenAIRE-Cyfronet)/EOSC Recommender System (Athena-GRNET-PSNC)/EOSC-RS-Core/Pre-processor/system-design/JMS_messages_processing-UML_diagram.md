```plantuml
@startuml
autonumber

title "Preprocessor - processing of JMS messages"

actor JMS
boundary "Preprocessor" as PreProc
control "Session Composer" as SC
control "Resources Statistics" as RStat
control "User Synchronizer" as USync
control "Service Synchronizer" as SSync
database Database as DB
actor Kafka

alt User Action
  JMS -> PreProc : Receive the message
  note over PreProc: User Session
  PreProc -> SC : To User Session
  SC -> Kafka : Publish new/updated User Session
else
  note over PreProc: Statistics
  PreProc -> RStat : Extract statistics
  note over RStat: Scheduled statistics backup (every x minutes)
  RStat -> DB : Backup part of data from the day
else
  note over RStat: Scheduled statistics calculations at midnight (DB)
  RStat -> DB : Trigger statistics calculations
  DB -> DB : Calculate statistics
  RStat <- DB : Inform about completed calculations
  RStat -> Kafka : Publish message about completed calculations
end

alt Resource sychronization
  JMS -> PreProc : Receive the message
else
  note over PreProc: User Event
  PreProc -> USync : Forward the Resource event
  USync -> USync : Check if it is a User event
  USync <-> DB : Check if the event is relevant (create/update/delete)
  USync -> Kafka : Publish the resource change
else
  note over PreProc: Service Event
  PreProc -> SSync : Forward the Resource event
  SSync -> SSync : Check if it is a Service event
  SSync <-> DB : Check if the event is relevant (create/update/delete)
  SSync -> Kafka : Publish the resource change
end

@enduml
'''