# ModUtils

This repository contains gradle scripts, and some data to remove the clutter from your mod's gradle files and make it easy to keep things updated.

## How to use

First you need to create a gradle project and configure your `build.gradle` file like this:

```groovy
buildscript {
    apply from: 'https://moddingx.github.io/ModUtils/v5/buildscript.gradle', to: buildscript
}

apply from: 'https://moddingx.github.io/ModUtils/v5/mod.gradle'
```

After that, you can import the project in your IDE. This will fail the first time, but you'll get a new file called `mod.properties`. Then you should configure this file. See section Properties.

Now you can run `gradle setup` which will create some new files for your mod.

## Properties

`mod.properties` contains some properties that you should fill in. (Bold properties are required)

| Property | Description |
| :---: | :--- |
| **modid** | The Mod Id |
| **group** | The maven group for the mod |
| **base_version** | The base version of the mod. This is not necessarily the full version. The full version is determined by the file found in the local maven repository defined by `local_maven`. It'll always be the base version plus a dot followed by a number that is one higher than the highest number of all files in the maven that start with this base version. If you don't set a `local_maven`, version is just set to `base_version`. |
| **forge_version** | The forge version to use. For example `1.16.5-36.1.65`. This is also used to determine the minecraft version to use. |
| fmlonly | Whether to use *fmlonly* instead of *forge. |
| mappings | The mappings to use. This is optional. If left out, the official mappings will be used. Format is `channel_version`. |
| local_maven | The local maven repository to use. This is used by the `publish` task and to determine the full version. If left out, publishing won't be available. |
| mixin | Whether this project uses mixins. Either `true` or `false`. |
| sources | Whether to generate SRG named sources jar. Either `true` or `false`. |
| mcupdate | When this property is set, a mcupdate target is loaded from [here](https://assets.moddingx.org/mcupdate). With the task `mcupdate` you can then prepare your project for the next major release of minecraft. In most cases this can be set to your minecraft version to update to. |
| production_runs | Whether runs should simulate a production environment. |
| **license** | The name of the project's license. |
| **license_url** | The url of the project's license. |

## Uploading to mod hosting sites

ModUtils supports upload to [CurseForge](https://www.curseforge.com/minecraft/mc-mods) and [Modrinth](https://www.modrinth.com/mods). For each upload type, you can set the following properties: (Bold properties are required)

| Property | Description |
| :---: | :--- |
| **project** | The project id of the mod. |
| release | The release type. One of `alpha`, `beta` and `release`. Default is `alpha`. |
| versions | The minecraft version-tags that should be added to a file (separated by comma). Default is the current minecraft version. |
| requirements | A list of projects that are required dependencies (separated by comma) |
| optionals | A list of projects that are optional dependencies (separated by comma) |

To set a property, set `<name>_<property>` in `mod.properties` where `<name>` is the website to upload to (`curse` or `modrinth`) and `<property>` is the property to set. If a property is not set in this format, the property `upload_<property>` is searched, so you can set properties for both CurseForge and Modrinth at the same time. However, you can't use `upload_project`.

## Secrets

ModUtils will look for a file named `secrets.properties` (the location can be changed with the environment variable `SECRET_PROPERTIES`) and load those properties into a global object named `secrets`. The keys for mod uploading are expected as `curse_auth` or `modrinth_auth` in that secret object.

## Mod properties

The properties defined in `mod.properties` will be placed in a global object named `mod`. Also some other properties will be added to this. All `mod` properties can be found below. (Non-bold properties may be absent). A property can be accessed with `mod.<name>` where `<name>` is the property name. To check, whether a property is present, use `'<name>' in mod`.

| Property | Type | Description |
| :---: | :---: | :--- |
| **modid** | `String` | The mod id. |
| **name** | `String` | The mod/project name. |
| **group** | `String` | The mod/project group. |
| **base_version** | `String` | The mod's base version as set in `mod.properties` |
| **version** | `String` | The mod/project version. |
| **minecraft** | `String` | The minecraft version in use. |
| **forge** | `String` | The forge version in use. (Without the minecraft version prefixed) |
| **fml** | `String` | The major part of the forge version. |
| **fmlonly** | `boolean` | Whether fmlonly mode is enabled. |
| **mapping_channel** | `String` | The mapping channel that is in use. |
| **mapping_version** | `String` | The mapping version that is in use. |
| **java** | `int` | The target java version for the current minecraft version. |
| **resource** | `int` | The resource pack version for the current minecraft version. |
| **data** | `int` | The datapack version for the current minecraft version. (If there is no datapack version, this is equal to the resource pack version. |
| local_maven | `String` | The local maven used for publishing and determining the full version. |
| mcupdate | `String` | The mcupdate target that is in use. |
| **license** | `String` | The mod's license. |
| **license_url** | `URL` | The mod's license url. |
| **sources** | `boolean` | Whether a source jar is generated. |
| **production_runs** | `boolean` | Whether production runs are enabled. |
| **mixin** | `boolean` | Whether mixin is enabled. |
| mixin_version | `String` | The target mixin version for the current minecraft version. |
| **run** | `<run>` | See below. |
| **gitChangelog** | `()String` | Method that gets the changelog from git commits in the current CI build. Empty string if no changelog can be generated. |
| curse | `<upload>` | Upload information for CurseForge. See below. |
| modrinth | `<upload>` | Upload information for Modrinth. See below. |

All non-standard properties in mod.properties are also copied into the `mod` object.

### Run properties

`mod.run` allows to tweak some aspects of the run configurations in use.

| Property | Type | Description |
| :---: | :---: | :--- |
| **sourceSet** | `(SourceSet)void` | Adds a secondary source set to the run configs. |
| **existing** | `(String)void` | Marks modid as existing during datagen. |

### Upload properties

`mod.curse` and `mod.modrinth` specify data for mod uploading:

| Property | Type | Description |
| :---: | :---: | :--- |
| **project** | `String` | The project id on the mod hosting site. |
| **release** | `String` | The release type for publishing on the mod hosting site. |
| **versions** | `List<String>` | The game version tags to use. |
| **requirements** | `List<String>` | Required dependencies. |
| **optionals** | `List<String>` | Optional dependencies. |

## Experimental Features

The [experimental](https://github.com/ModdingX/ModUtils/tree/experimental) branch contains things that have not yet been tested enough to go into the main branch or contain breaking changes. Use it at your own risk. To apply it, use:

```groovy
buildscript {
    apply from: 'https://moddingx.github.io/ModUtils/experimental/buildscript.gradle', to: buildscript
}

apply from: 'https://moddingx.github.io/ModUtils/experimental/mod.gradle'
```

Any pull request that is not a bugfix for an older version must target the experimental branch.
