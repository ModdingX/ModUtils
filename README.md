# ModUtils

This repository contains gradle scripts, and some data to remove the clutter from your mod's gradle files and make it easy to keep things updated.

## How to use

First you need to create a gradle project and configure your `build.gradle` file like this:

```groovy
buildscript {
    apply from: 'https://moddingx.github.io/ModUtils/v4/buildscript.gradle', to: buildscript
}

apply from: 'https://moddingx.github.io/ModUtils/v4/mod.gradle'
```

After that, you can import the project in your IDE. This will fail the first time, but you'll get a new file called `gradle.properties`. Then you should configure this file. See section Properties.

Now you can run `gradle setup` which will create some new files for your mod.

## Properties

`gradle.properties` contains some properties that you should fill in. (Bold properties are required)

| Property | Description                                                                                                                                                                                                                                                                                                                                                                                                                       |
| :---: |:----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **modid** | The Mod Id                                                                                                                                                                                                                                                                                                                                                                                                                        |
| **group** | The maven group fo the mod                                                                                                                                                                                                                                                                                                                                                                                                        |
| **base_version** | The base version of the mod. This is not necessarily the full version. The full version is determined by the file found in the local maven repository defined by `local_maven`. It'll always be the base version plus a dot followed by a number that is one higher than the highest number of all files in the maven that start with this base version. If you don't set a `local_maven`, version is just set to `base_version`. |
| **forge_version** | The forge version to use. For example `1.16.5-36.1.65`. This is also used to determine the minecraft version to use.                                                                                                                                                                                                                                                                                                              |
| mappings | The mappings to use. This is optional. If left out, the official mappings will be used. Format is `channel_version`.                                                                                                                                                                                                                                                                                                              |
| local_maven | The local maven repository to use. This is used by the `publish` task and to determine the full version. If left out, publishing won't be available.                                                                                                                                                                                                                                                                              |
| mixins | Whether this project uses mixins. Either `true` or `false`.                                                                                                                                                                                                                                                                                                                                                                       |
| sources | Whether to generate SRG named sources jar. Either `true` or `false`.                                                                                                                                                                                                                                                                                                                                                              |
| mcupdate_target | When this property is set, a mcupdate target is loaded from [here](https://assets.moddingx.org/mcupdate). With the task `mcupdate` you can then prepare your project for the next major release of minecraft. In most cases this can be set to you'r minecraft version to update to.                                                                                                                                              |
| production_runs | Whether runs should simulate a production environment.                                                                                                                                                                                                                                                                                                                                                                            |
| **license_name** | The name of the project's license.                                                                                                                                                                                                                                                                                                                                                                                                |
| **license_url** | The url of the project's license.                                                                                                                                                                                                                                                                                                                                                                                                 |

## Uploading to mod hosting sites

ModUtils supports upload to [CurseForge](https://www.curseforge.com/minecraft/mc-mods) and [Modrinth](https://www.modrinth.com/mods). For each upload type, you can set the following properties: (Bold properties are required)

| Property | Description |
| :---: | :--- |
| **project** | The project id of the mod. |
| release | The release type. One of `alpha`, `beta` and `release`. Default is `alpha`. |
| versions | The minecraft version-tags that should be added to a file (separated by comma). Default is the current minecraft version. |
| requirements | A list of projects that are required dependencies (separated by comma) |
| optionals | A list of projects that are optional dependencies (separated by comma) |

To set a property, set `<name>_<property>` in `gradle.properties` where `<name>` is the website to upload to (`curse` or `modrinth`) and `<property>` is the property to set. If a property is not set in this format, the property `upload_<property>` is searched, so you can set properties for both CurseForge and Modrinth at the same time. However, you can't use `upload_project`.

When using one of the upload targets, you need to make your token available under the property `<name>_auth` with `<name>` being the website to upload to (`curse` or `modrinth`). You can use a secrets file for this as ModUtils will load [this](https://github.com/MinecraftModDevelopment/Gradle-Collection/blob/master/generic/secrets.gradle) gradle script when upload is used.

## Experimental Features

The [experimental](https://github.com/ModdingX/ModUtils/tree/experimental) branch contains things that have not yet been tested enough to go into the main branch or contain breaking changes. Use it at your own risk. To apply it, use:

```groovy
buildscript {
    apply from: 'https://moddingx.github.io/ModUtils/experimental/buildscript.gradle', to: buildscript
}

apply from: 'https://moddingx.github.io/ModUtils/experimental/mod.gradle'
```

Any pull request that is not a bugfix for an older version must target the experimental branch.
