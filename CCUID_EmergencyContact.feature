# ###################################################
# Author:       pbharath.kumar@tesco.com             #
# Date:         14/09/2021                          #
# Version:      v0.1                                #
# Description : Emergency Contact GET endpoint tests   #
# ###################################################
Feature: Personal Details API GET endpoint test

  Background:

    ## Setting up the URL
    * json apiDetailJson = apiMetaData['personDetails']
    * url apiDetailJson['baseUrl'] + apiDetailJson['endpoints']['ColleagueUUIDProfile']

    #Retrieving Tokens
    * def identityToken = karate.read("file:target/idToken.txt")
    * def meToken_manager = karate.read("file:target/meToken_manager.txt")


    * def emergencyContactReqBody = read('classpath:common/testData/dev/personDetails/EmergencyContactReqBody_CUUID.json')
    * def addressDataJson = read('classpath:common/testData/dev/personDetails/PersonDetails.json')

    #Java Method
    * def jUtils = Java.type('JavaUtils.MyUtils')

  @PERS-T1233 @EmergencyContact @PersonalDetails @PersonalDetails
  Scenario Outline: Verify Response 201 with valid Authtoken <SNO>_<TestDesc>
    *  call read('CCUID_EmergencyContact.feature@ColleagueUUIDEmergencyContacts_GET_200')
    * path '<ColleagueUUID>' +  "/emergency-contacts"
    * header Authorization = 'bearer ' + identityToken
    * header traceId = traceId
    * emergencyContactReqBody.version = jUtils.<version_method>()
    * request emergencyContactReqBody
    * method post
    * status 201
    * jUtils.<tempVersion>(response.version)
    * jUtils.<emergencyID_method>(response.emergencyContacts[0].emergencyContactId)

    Examples:
      | SNO                 | TestDesc                | ColleagueUUID                        | version_method       | emergencyID_method     |tempVersion|
      | PERS-AUTO-TC001-TC1 | colleague login details | f14e4b60-9928-42e2-96dc-ae77a3abbb15 | getVersion_colleague | setEmergency_colleague |setVersionTemp_colleague|
      | PERS-AUTO-TC001-TC2 | manager login details   | 91606b51-57f4-45a3-989b-d7b85a520145 | getVersion_Manager   | setEmergency_Manager   |setVersionTemp_manager|


    # Put Action
  @PERS-T1234 @EmergencyContact @PersonalDetails
  Scenario Outline: Verify the Response 200 by changing firstName of valid Cuuid <SNO>_<TestDesc>
    * call read('CCUID_EmergencyContact.feature@ColleagueUUIDEmergencyContacts_GET_200')
    * java.lang.Thread.sleep(30000)
    * path '<ColleagueUUID>' +  "/emergency-contacts"
    * path jUtils.<EmergencyContactId>()
    * header Authorization = 'bearer ' + identityToken
    * header traceId = traceId
    * emergencyContactReqBody.firstName = "ZAutoLotus"
    * emergencyContactReqBody.version = jUtils.<methodName>()
    * request emergencyContactReqBody
    * method put
    * status 200
    Examples:
      | SNO                 | TestDesc                | ColleagueUUID                        | methodName           | EmergencyContactId     |
      | PERS-AUTO-TC002-TC1 | colleague login details | f14e4b60-9928-42e2-96dc-ae77a3abbb15 | getVersion_colleague | getEmergency_colleague |
      | PERS-AUTO-TC002-TC2 | manager login details   | 91606b51-57f4-45a3-989b-d7b85a520145 | getVersion_Manager   | getEmergency_Manager   |

  @PERS-T1234 @EmergencyContact @PersonalDetails
  Scenario Outline: Verify Response for put cases <SNO>_<TestDesc>
    * call read('CCUID_EmergencyContact.feature@ColleagueUUIDEmergencyContacts_GET_200')
    * path '<ColleagueUUID>' +  "/emergency-contacts"
    * path jUtils.<EmergencyContactId>()
    * header Authorization = 'bearer ' + <TokenDetails>
    * header traceId = traceId

    * emergencyContactReqBody.firstName = <FirstName>
    * emergencyContactReqBody.relationship = <Relationship>
    * emergencyContactReqBody.version = <version_method>
    * request emergencyContactReqBody

    * method put
    * match responseStatus == <ResponseCode>
    * match response.code == '<ResponseCode>'
    * match response.message contains '<ResponseMessage>'
    Examples:
      |SNO  | TestDesc          |TokenDetails                           |ColleagueUUID                          |version_method           |FirstName|Relationship|EmergencyContactId      |ResponseCode    |ResponseMessage|
      |1289 |Invalid Token      |'f14e4b60-9928-42e2-96dc-ae77a3abbb15' |f14e4b60-9928-42e2-96dc-ae77a3abbb15   |'2022-10-24T19:34:05.776'|'Lotus'  |'NEPHEW'    |getEmergency_colleague  |401             |Invalid or missing authorization header|
      |1389 |Blank Token        |''                                     |f14e4b60-9928-42e2-96dc-ae77a3abbb15   |'2022-10-24T19:34:05.776'|'Lotus'  |'NEPHEW'    |getEmergency_colleague  |401             |Invalid or missing authorization header|
      |1489 |Swap Token         |meToken_manager                        |f14e4b60-9928-42e2-96dc-ae77a3abbb15   |'2022-10-24T19:34:05.776'|'Lotus'  |'NEPHEW'    |getEmergency_colleague  |403             |You\'re not allowed to access the requested resource|
      |1589 |Blank CUUID        |identityToken                          |                                       |'2022-10-24T19:34:05.776'|'Lotus'  |'NEPHEW'    |getEmergency_colleague  |404             |No matching endpoint found|
      |1689 |Blank Version      |identityToken                          |f14e4b60-9928-42e2-96dc-ae77a3abbb15   |''                       |'Lotus'  |'NEPHEW'    |getEmergency_colleague  |400             |must not be null               |
      |1789 |Blank Firstname    |identityToken                          |f14e4b60-9928-42e2-96dc-ae77a3abbb15   |'2022-10-24T19:34:05.776'|' '       |'NEPHEW'   |getEmergency_colleague  |400             |must not be blank               |
      |1989 |Blank Relationship |identityToken                          |f14e4b60-9928-42e2-96dc-ae77a3abbb15   |'2022-10-24T19:34:05.776'|'Lotus'  |''          |getEmergency_colleague  |400             |must not be blank              |



  @PERS-T1235 @EmergencyContact @PersonalDetails
  Scenario Outline: Verify the Response 200 by deleting the record with valid authtoken <SNO>_<TestDesc>
    * call read('CCUID_EmergencyContact.feature@ColleagueUUIDEmergencyContacts_GET_200')
    * java.lang.Thread.sleep(30000)
    * path '<ColleagueUUID>' +  "/emergency-contacts"
    * path jUtils.<EmergencyContactId>()
    * header Authorization = 'bearer ' + identityToken
    * header version = jUtils.<getVersion>()
    * header traceId = traceId
    * method delete
    * status 200
    Examples:
      | SNO                 | TestDesc                | ColleagueUUID                        | getVersion           | EmergencyContactId     |
      | PERS-AUTO-TC003-TC1 | colleague login details | f14e4b60-9928-42e2-96dc-ae77a3abbb15 | getVersion_colleague | getEmergency_colleague |
      | PERS-AUTO-TC003-TC2 | manager login details   | 91606b51-57f4-45a3-989b-d7b85a520145 | getVersion_Manager   | getEmergency_Manager   |

  @PERS-T1245 @EmergencyContact @PersonalDetails
  Scenario Outline: Verify the 400 response when version is kept blank <SNO>_<TestDesc>
    * call read('CCUID_EmergencyContact.feature@ColleagueUUIDEmergencyContacts_GET_200')
    * path '<ColleagueUUID>' +  "/emergency-contacts"
    * path jUtils.getEmergency_colleague()
    * header Authorization = 'bearer ' + <TokenDetails>
    * header version = <version_method>
    * header traceId = traceId

    * method delete

    * match responseStatus == <ResponseCode>
    * match response.code == '<ResponseCode>'
    * match response.message contains '<ResponseMessage>'
    Examples:
      | SNO                 | TestDesc             | TokenDetails    | ColleagueUUID                        | version_method                         | ResponseCode | ResponseMessage                                                                     |
      | PERS-AUTO-TC009-TC1 | Swap token           | meToken_manager | f14e4b60-9928-42e2-96dc-ae77a3abbb15 | '2022-10-24T19:34:05.776'              | 403          | You\'re not allowed to access the requested resource                                |
      | PERS-AUTO-TC009-TC2 | Blank token          | ''              | f14e4b60-9928-42e2-96dc-ae77a3abbb15 | '2022-10-24T19:34:05.776'              | 401          | Invalid or missing authorization header                                             |
      | PERS-AUTO-TC009-TC3 | Blank version        | identityToken   | f14e4b60-9928-42e2-96dc-ae77a3abbb15 | ''                                     | 400          | Invalid value  provided for parameter : Version                                     |
      | PERS-AUTO-TC009-TC4   | TraceID as versionID | identityToken   | f14e4b60-9928-42e2-96dc-ae77a3abbb15 | '992ffb5a-d866-4feb-a60b-dcb2bcef0658' | 400          | Invalid value 992ffb5a-d866-4feb-a60b-dcb2bcef0658 provided for parameter : Version |

  @PERS-T1236 @EmergencyContact @ColleagueUUIDEmergencyContacts_GET_200
  Scenario Outline: Verify the Response 200 by giving valid authtoken <SNO>_<TestDesc>
    * java.lang.Thread.sleep(4000)
    * path '<ColleagueUUID>' +  "/emergency-contacts"
    * header Authorization = 'bearer ' + identityToken
    * header traceId = traceId
    * method get
    * match responseStatus == 200
    *  jUtils.<methodName>(response.version)

    Examples:
      | SNO                 | TestDesc                | ColleagueUUID                        | methodName           |
      | PERS-AUTO-TC004-TC1 | colleague login details | f14e4b60-9928-42e2-96dc-ae77a3abbb15 | setVersion_colleague |
      | PERS-AUTO-TC004-TC2 | manager login details   | 91606b51-57f4-45a3-989b-d7b85a520145 | setVersion_Manager   |

  @PERS-T1237 @EmergencyContact @PersonalDetails
  Scenario Outline: Verify the Response 401 and 404 by giving invalid AuthToken,Blank token <SNO>_<TestDesc>
    * path '<ColleagueUUID>' +  "/emergency-contacts"
    * header Authorization = 'bearer ' + <TokenDetails>
    * header traceId = traceId
    * method get
    * match responseStatus == <ResponseCode>
    * match response.code == '<ResponseCode>'
    * match response.message contains '<ResponseMessage>'
    Examples:
      | SNO                 | TestDesc          | TokenDetails                           | ColleagueUUID                        | ResponseCode | ResponseMessage                                                         |
      | PERS-AUTO-TC005-TC1 | In Valid Token    | 'f14e4b60-9928-42e2-96dc-ae77a3abbb15' | f14e4b60-9928-42e2-96dc-ae77a3abbb15 | 401          | Invalid or missing authorization header                                 |
      | PERS-AUTO-TC005-TC2 | Blank Token       | ''                                     | f14e4b60-9928-42e2-96dc-ae77a3abbb15 | 401          | Invalid or missing authorization header                                 |
      | PERS-AUTO-TC005-TC3 | Swap Token        | meToken_manager                        | f14e4b60-9928-42e2-96dc-ae77a3abbb15 | 403          | Access denied to this colleague                                         |
      | PERS-AUTO-TC005-TC4 | Blank ID          | identityToken                          |                                      | 400          | Invalid value emergency-contacts provided for parameter : colleagueUUID |
      | PERS-AUTO-TC005-TC5   | Trace ID as CUUID | identityToken                          | 5d4b42d5-80ba-4eee-9cf4-f0a342c982a7 | 404          | wasn\'t found                                                           |
#      |511 |forbidden_authToken  |addressDataJson.common.forbidden_authToken|f14e4b60-9928-42e2-96dc-ae77a3abbb15|403             |You\'re not allowed to access the requested resource|

  @PERS-T1238 @EmergencyContact @PersonalDetails
  Scenario Outline: Verify the Response by giving invalid payload <SNO>_<TestDesc>
    * java.lang.Thread.sleep(30000)
    * path '<ColleagueUUID>' +  "/emergency-contacts"
    * header Authorization = 'bearer ' + <TokenDetails>
    * header traceId = traceId

    * emergencyContactReqBody.version = jUtils.<version_method>()
    * emergencyContactReqBody.firstName = <FirstName>
    * emergencyContactReqBody.relationship = <Relationship>
    * request emergencyContactReqBody

    * method post
    * match responseStatus == <ResponseCode>
    * match response.code == '<ResponseCode>'
    * match response.message contains '<ResponseMessage>'

    Examples:
      | SNO                 | TestDesc                    | TokenDetails                           | ColleagueUUID                        | version_method           | FirstName | Relationship | ResponseCode | ResponseMessage                                      |
      | PERS-AUTO-TC006-TC1 | Invalid Token               | 'f14e4b60-9928-42e2-96dc-ae77a3abbb15' | 72830537-97bc-4316-8031-e090fe08f836 | getVersionTemp_colleague | 'BNicole' | 'SISTER'     | 401          | Invalid or missing authorization header              |
      | PERS-AUTO-TC006-TC2 | Blank Token                 | ''                                     | 72830537-97bc-4316-8031-e090fe08f836 | getVersionTemp_colleague | 'BNicole' | 'SISTER'     | 401          | Invalid or missing authorization header              |
      | PERS-AUTO-TC001-TC3 | Swap Token                  | meToken_manager                        | f14e4b60-9928-42e2-96dc-ae77a3abbb15 | getVersionTemp_colleague | 'BNicole' | 'SISTER'     | 403          | You\'re not allowed to access the requested resource |
      | PERS-AUTO-TC001-TC4 | Expired colleague version   | identityToken                          | f14e4b60-9928-42e2-96dc-ae77a3abbb15 | getVersionTemp_colleague | 'BNicole' | 'SISTER'     | 409          | resource modified from another source, please get the new version and try again|
      | PERS-AUTO-TC001-TC5 | Expired manager version     | identityToken                          | 91606b51-57f4-45a3-989b-d7b85a520145 | getVersionTemp_manager   | 'BNicole' | 'SISTER'     | 409          | resource modified from another source, please get the new version and try again|

  @PERS-T1238 @EmergencyContact @PersonalDetails
  Scenario Outline: Verify the Response 400 by giving invalid payload <SNO>_<TestDesc>
    * path '<ColleagueUUID>' +  "/emergency-contacts"
    * header Authorization = 'bearer ' + <TokenDetails>
    * header traceId = traceId

    * emergencyContactReqBody.version = <version_method>
    * emergencyContactReqBody.firstName = <FirstName>
    * emergencyContactReqBody.relationship = <Relationship>
    * request emergencyContactReqBody

    * method post
    * match responseStatus == <ResponseCode>
    * match response.code == '<ResponseCode>'
    * match response.message contains '<ResponseMessage>'

    Examples:
      | SNO                 | TestDesc           | TokenDetails                           | ColleagueUUID                        | version_method            | FirstName | Relationship | ResponseCode | ResponseMessage                                      |
      | PERS-AUTO-TC001-TC6 | Blank CUUID        | identityToken                          |                                      | '2022-10-24T19:34:05.776' | 'BNicole' | 'SISTER'     | 404          | No matching endpoint found                           |
      | PERS-AUTO-TC001-TC7 | Blank Version      | identityToken                          | 72830537-97bc-4316-8031-e090fe08f836 | ''                        | 'BNicole' | 'SISTER'     | 400          | must not be null                                     |
      | PERS-AUTO-TC001-TC8 | Blank Firstname    | identityToken                          | 72830537-97bc-4316-8031-e090fe08f836 | '2022-10-24T19:34:05.776' | ' '       | 'SISTER'     | 400          | must not be blank                                    |
      | PERS-AUTO-TC001-TC9 | Blank Relationship | identityToken                          | 72830537-97bc-4316-8031-e090fe08f836 | '2022-10-24T19:34:05.776' | 'BNicole' | ' '          | 400          | must not be blank                                    |