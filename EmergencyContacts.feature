@personalDetailsUI @navigation
Feature: PD - Emergency Contact details Regression validations

  @PERS_T619 @PersonalDetailsRegression @EmergencyContactDetailsRegression @DeleteIFExistsEmergencyContactE2E
  Scenario: Delete EmergencyContact If Exists
    Given I login to DEX UI as "User_7031"
    And I navigate to "PERSONALDETAILS" using hamburger Menu
    Then Delete Emergency Contact IF exists

  @PERS-T1298 @PersonalDetailsRegression @EmergencyContactDetailsRegression @AddEmergencyContact_Regression
  Scenario: Add Emergency Contact
    Given I login to DEX UI as "User_7031"
    And I navigate to "PERSONALDETAILS" using hamburger Menu
    And Click on Add Button to proceed Next "EC"
    And Fill all the EC details "Add" "Regression"
    And Save details "EC" "Add"
    Then Validate Success Message "Add"
    Then I Validate Emergency contact full name "Add"

  @PERS-TC1300 @PersonalDetailsRegression @EmergencyContactDetailsRegression @CancelEmergencyContact
  Scenario: Cancel Emergency Contact
    Given I login to DEX UI as "User_7031"
    And I navigate to "PERSONALDETAILS" using hamburger Menu
    And Click on Add Button to proceed Next "EC"
    And Fill all the EC details "Add" "EC"
    And Cancel operation
     And check header to confirm it is landed to correct page

  @PERS-T1301 @PersonalDetailsRegression @EmergencyContactDetailsRegression @Close_AddEmergencyContact
  Scenario: Close Emergency Contact on Add Screen
    Given I login to DEX UI as "User_7031"
    And I navigate to "PERSONALDETAILS" using hamburger Menu
    And Click on Add Button to proceed Next "EC"
    And Fill all the EC details "Add" "EC"
    And Close operation
     And check header to confirm it is landed to correct page

  @PERS-T1302 @PersonalDetailsRegression @EmergencyContactDetailsRegression @Backward_AddEmergencyContact
  Scenario: Backward Emergency Contact on Add Screen
    Given I login to DEX UI as "User_7031"
    And I navigate to "PERSONALDETAILS" using hamburger Menu
    And Click on Add Button to proceed Next "EC"
    And Fill all the EC details "Add" "EC"
    And Click on Back button to check the navigation
     And check header to confirm it is landed to correct page


  @PERS-T1303 @PersonalDetailsRegression @EmergencyContactDetailsRegression @AddEmergencyContact_Validation
  Scenario Outline: Validate Add EmergencyContact <SNO>_<Description>
    Given I login to DEX UI as "User_7031"
    And I navigate to "PERSONALDETAILS" using hamburger Menu
    And Click on Add Button to proceed Next "EC"
    And Enter "<firstName>" "<lastName>" "<mobile>" "<relationShip>" and validate alert message
    Examples:
      |SNO|Description                    |firstName  |lastName    |relationShip|mobile     |
      |1  |Blank relationShip             |Jim        |Carter      |            |07334567790|
      |2  |Blank firstName                |           |Carter      |Brother     |07334567790|
      |3  |Blank lastName                 |Jim        |            |Brother     |07334567790|
      |4  |Blank mobile                   |Jim        |Carter      |Brother     |           |

      |5  |Blank firstName & lastName     |           |            |Brother     |07334567790|
      |6  |Blank firstName & relationship |           |Carter      |            |07334567790|
      |6  |Blank firstName & mobile       |           |Carter      |Brother     |           |



  @PERS-T1304 @PersonalDetailsRegression @EmergencyContactDetailsRegression @EditEmergencyContact_Regression
  Scenario: Edit Emergency Contact
    Given I login to DEX UI as "User_7031"
    And I navigate to "PERSONALDETAILS" using hamburger Menu
    And Click on Edit Button to proceed Next with updating "Regression"
    And Fill all the EC details "Edit" "Regression"
    And Save details "EC" "Edit"
    Then Validate Success Message "Edit"
    Then I Validate Emergency contact full name "Edit"


  @PERS-T1305 @PersonalDetailsRegression @EmergencyContactDetailsRegression @Close_EditEmergencyContact
  Scenario: Close Emergency Contact on Edit Screen
    Given I login to DEX UI as "User_7031"
    And I navigate to "PERSONALDETAILS" using hamburger Menu
    And Click on Edit Button to proceed Next with updating "Regression"
    And Fill all the EC details "Edit" "EC"
    And Close operation
     And check header to confirm it is landed to correct page



  @PERS-T1306 @PersonalDetailsRegression @EmergencyContactDetailsRegression @Backward_EditEmergencyContact
  Scenario: Backward Emergency Contact on Edit Screen
    Given I login to DEX UI as "User_7031"
    And I navigate to "PERSONALDETAILS" using hamburger Menu
    And Click on Edit Button to proceed Next with updating "Regression"
    And Fill all the EC details "Edit" "EC"
    And Click on Back button to check the navigation
     And check header to confirm it is landed to correct page


  @PERS-T1307 @PersonalDetailsRegression @EmergencyContactDetailsRegression @EditEmergencyContact_Validation
  Scenario Outline: Validate Edit EmergencyContact <SNO>_<Description>
    Given I login to DEX UI as "User_7031"
    And I navigate to "PERSONALDETAILS" using hamburger Menu
    And Click on Edit Button to proceed Next with updating "Regression"
    And Enter "<firstName>" "<lastName>" "<mobile>" "<relationShip>" and validate alert message
    Examples:
      |SNO|Description                    |firstName  |lastName    |relationShip|mobile     |
      |1  |Blank relationShip             |Jim        |Carter      |            |07334567790|
      |2  |Blank firstName                |           |Carter      |Brother     |07334567790|
      |3  |Blank lastName                 |Jim        |            |Brother     |07334567790|
      |4  |Blank mobile                   |Jim        |Carter      |Brother     |           |

      |5  |Blank firstName & lastName     |           |            |Brother     |07334567790|
      |6  |Blank firstName & relationship |           |Carter      |            |07334567790|
      |6  |Blank firstName & mobile       |           |Carter      |Brother     |           |


  @PERS-T1308 @PersonalDetailsRegression @EmergencyContact @Cancel_EditEmergencyContact
  Scenario: Cancel Edit Emergency Contact
    Given I login to DEX UI as "User_7031"
    And I navigate to "PERSONALDETAILS" using hamburger Menu
    And Click on Edit Button to proceed Next with updating "Regression"
    And Fill all the EC details "Edit" "EC"
    And Cancel operation
     And check header to confirm it is landed to correct page

  @PERS-T1309 @PersonalDetailsRegression @EmergencyContactDetailsRegression @Cancel_DeleteEmergencyContact
  Scenario: Cancel Delete EmergencyContact
    Given I login to DEX UI as "User_7031"
    And I navigate to "PERSONALDETAILS" using hamburger Menu
    And Click on Edit Button to proceed Next with updating "Regression"
    And Cancel Delete Emergency Contact
     And check header to confirm it is landed to correct page

  @PERS-T1310 @PersonalDetailsRegression @EmergencyContactDetailsRegression @DeleteEmergencyContact_Regression
  Scenario: Delete EmergencyContact
    Given I login to DEX UI as "User_7031"
    And I navigate to "PERSONALDETAILS" using hamburger Menu
    And Click on Edit Button to proceed Next with updating "Regression"
    And Delete Emergency Contact
    Then Validate Success Message "Delete"










