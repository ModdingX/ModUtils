# ModUtils

This repository contains gradle scripts, and some data to remove the clutter from your mod's gradle files and make it easy to keep things updated.

## How to use

First you need to create a gradle project and configure your `build.gradle` file like this:

```groovy
buildscript {
    apply from: 'https://raw.githubusercontent.com/noeppi-noeppi/ModUtils/master/buildscript.gradle', to: buildscript
}

apply from: 'https://raw.githubusercontent.com/noeppi-noeppi/ModUtils/master/mod.gradle'
```

After that, you can import the project in your IDE. This will fail the first time, but you'll get a new file called `gradle.properties`. Then you should configure this file. See section Properties.

Now you can run `gradle setup` which will create some new files. Now you're ready to go.

## Properties

`gradle.properties` contains some properties that you should fill in.

| Property | Description |
| :---: | :--- |
| `modid` | The Mod Id |
| `group` | The maven group fo the mod |
| `base_version` | The base version of the mod. This is not the full version. The full version is determined by the file found in the local maven repository defined by `local_maven`. It'll always be the base version plus a dot followed by a number that is one higher than the highest number of all files in the maven that start with this base version. |
| `mc_version` | The minecraft version to use |
| `forge_version` | The forge version to use |
| `mappings` | The mappings to use. This is optional. If left out, the official mappings of `mc_version` will be used. Format is `channel:version` or the string `custom`. See [Custom Mappings](#custom-mappings) for this. |
| `local_maven` | The local maven repository to use. This is used by the `publish` task and to determine the full version. |
| `mixins` | Whether this project uses mixins. Either `true` or `false`. |
| `license_name` | The name of the project's license. |
| `license_url` | The url of the project's license. |
| `curse_project` | The project id on CurseForge. This is optional. If left out, CurseForge upload does not work.  |
| `curse_release` | The release type on CurseForge. This is optional. Default is `alpha` |
| `curse_versions` | The minecraft version-tags that should be added to a file on CurseForge (separated by commas). This is optional. Default is the value of `mc_version` |
| `curse_requirements` | A list of projects that are required dependencies on CurseForge (separated by commas). |
| `curse_optionals` | A list of projects that are optional dependencies on CurseForge (separated by commas). |

# Custom Mappings

You can set `mappings` to `custom`. In this case you need to create a file called `mappings.mcm`. This file will be used to generate the mappings that should be used. `mappings.mcm` is a [MappingConverter](https://github.com/noeppi-noeppi/MappingConverter) script. It will get two variables set by ModUtils:

  * `${mc}` will be the minecraft version set in `gradle.properties`
  * `${out}` will be the path where the mapping should be written to.