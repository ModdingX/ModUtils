# Updating to ModUtils v2

There are a few changes needed to update to ModUtils v2.

  * You need to change the `apply from` statements in your `build.gradle` to use the `v2` branch instead of `master`.
  * In `gradle.properties` put the minecraft version before the forge version separated by a `-`. Then delete the `mc_version` property
  * In `gradle.properties` replace the colon in the mappings property with an underscore (`_`)

## Updating to 1.17

If you also want to update to 1.17, first do the steps above. Then set the property `mcupdate` to `true` in `gradle.properties` and run `gradle mcupdate` to prepare your project for 1.17.