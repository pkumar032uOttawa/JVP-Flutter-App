# jvp_app

A new Flutter project for Jugular Vein Pressure

## How to clone and use it

1. Core code files are all in lib/ folder. Those are all you need for pages, utils, functionalities.
2. Dependencies are in pubspec.yaml. You can download thoese dependencies easily
3. Media files like pictures, icons, are in assets/ folder, you also need to configure the path to point it to assets folder so that you can use it
4. fonts are in fonts/ folder

## Problems you might have while cloning and running it
1. you need to configure miminum SDK JDK versions according to dependencies. Right now, I hardcode the version which is a bad practice. Feel free to adjust the versions by yourself
2. you might get the problem of "Warning:(9, 9) Kotlin version that is used for building with Gradle (1.6.0) differs from the one bundled into the IDE plugin (1.8.0)". This can be solved by changing either IDE Plugin version or project Gradle version

## What if you can't run
I suggest you to create a new Flutter project, import the lib\, fonts\, assets\, pubspec.yaml and then configure the rest based on errors encountered.

That would be the best way to correctly set up this project.
