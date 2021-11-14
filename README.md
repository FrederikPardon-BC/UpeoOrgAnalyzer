# UpeoOrgAnalyzer


```
Package Name: UpeoAnalyzer
Version: 1.0

A handy package for auditing your org.


Installation URL Prod: https://login.salesforce.com/packaging/installPackage.apexp?p0=04t09000000GEuD
Installation URL Sandbox: https://test.salesforce.com/packaging/installPackage.apexp?p0=04t09000000GEuD
Password: UpeoIsCool
Dependencies: none
```

The Upeo Analyze package pulls information about your org from
various sources and bundles them in a format that can be easily reported on.

For the moment it analyzes the following:

* Objects with a large set of records
* Objects with a limited set of records
* Object Field size (objects with a lot of fields)
* Field usage analysis: get insights in how often a field is filled out or blank
* Objects with records that haven't been modified in the last 2 years
* Flow execution data: find out how often a Flow has been called or which flows haven't been executed in a long time
* Validation rules: shows both active and inactive validation rules per object
* Workflow rule data: get insights in the nbr of both active and inactive workflows per object

This is just what the app analyzes in the first version. More will be added as we go.

## Usage

Before running this, make sure you followed the steps below that walk you through setting up a connected app and auth provider
Make sure you assigned the permission set 'UpeoAnalyzer' to your user!

Access the app by opening Upeo Analyzer from the App List:

![image](assets/images/analyzer.png)

Go to the Upeo Optimizer tab to launch the analyses you want

The component on the left can be used to analyze object field usage

The component on the right can be used to get the full analysis of your org

The results are stored in the Additional Org Metrics object

Some dashboards and reports come provided with the package, but feel free to add your own


![image](assets/images/upeoanalyzer.PNG)

## Feedback

Contact frederik.pardon@upeoconsulting with questions or features you would like to see included






After installing, you will need to create a Connected App, an Auth Provider and link a Named Credential in order to make the callouts work.

To work with REST API in LC you need to create three things -

Connected Apps
Auth Provider
Named Credentials (Already part of the package)

## Connected App

- Go to Setup, and enter 'App Manager' in the Quick Find box. Click on App Manager.

![image](assets/images/AppManager.PNG)

- Create a new Connected App and fill out:

  * Connected App Name: UpeoOptimizer
  * Contact Email: your email address
  * Check 'Enable OAuth Settings' under the API Section
  * Set a temporary URL as the Callback URL, we'll update that later (Eg https://login.salesorce.com)
  * Set 'Full Access (full)' and 'Perform requests at any time (refresh token, offline_access)' as the Selected OAUth Scopes
  * Leave the rest of the fields as they are
  * Save
  * Copy the Consumer Key and the Consumer Secret that is generated

![image](assets/images/connectedApp.PNG)
![image](assets/images/keyandsecret.PNG)



## Auth Provider

- Enter Auth. Providers in the Quick Find box

![image](assets/images/authProviders.PNG)

- Create a new Auth. Provider
- Select Salesforce as the Provider Type
- Fill out the following:

  * Name: OptimizerUpeo
  * URL Suffix: OptimizerUpeo
  * Consumer Key: paste the Consumer Key from the Connected App you created here
  * Consumer Secret: paste the Consumer Secret from the Connected App you created here
  * Default scopes: refresh_token full (mind the _ and the space!)
  * Save

 ![image](assets/images/authDetails.PNG)

- Under the Section 'Salesforce Configuration' a number of links will be generated. Copy the Callback URL:

![image](assets/images/AuthCallbackURL.PNG)

- Go back to the Connected App you created and update the Callback URL to the one you copied
- Save the Connected App

![image](assets/images/callbackConnectedApp.PNG)


## Named Credential

- Enter Auth. Providers in the Quick Find box
- Open UpeoOptimizer
- Set the URL to your Org's Base URL
- Set the Identity Type to Named Principal
- Set the Authentication Protocal to 0Oath 2.0
- Click the looking glass next to Authentication Provider and Select the Auth Provider you just created
- Set the Scope to refresh_token full (mind the _ and the space!)
- Save

![image](assets/images/namedcred.PNG)

- You'll be redirected to a Login Screen.
- Login and Allow Access to the Application

You're done!

## Permission Set

Assign the UpeoAnalyzer Permission set to the users who need access









