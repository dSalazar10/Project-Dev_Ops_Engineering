In order for you to be able to create blue ocean pipelines you need to modify the security settings:
1) Manage Jenkins > Configure Global security
- Set "Security Realm" to "Jenkins’ own user database" & check "Allow users to sign up"
- Set "Strategy" to "Logged-in users can do anything"
2) Sign up for an account
3) Manage Jenkins > Configure Global security
- uncheck "Allow users to sign up"