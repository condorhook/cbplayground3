# allows to add DEPLOYMENTFOLDERS and links to the Felgo library and QtCreator auto-completion
CONFIG += felgo

# uncomment this line to add the Live Client Module and use live reloading with your custom C++ code
# for the remaining steps to build a custom Live Code Reload app see here: https://felgo.com/custom-code-reload-app/
# CONFIG += felgo-live

# Project identifier and version
# More information: https://felgo.com/doc/felgo-publishing/#project-configuration
PRODUCT_IDENTIFIER = com.condorhook.playground.games
PRODUCT_VERSION_NAME = 1.0
PRODUCT_VERSION_CODE = 1

# Optionally set a license key that is used instead of the license key from
# main.qml file (App::licenseKey for your app or GameWindow::licenseKey for your game)
# Only used for local builds and Felgo Cloud Builds (https://felgo.com/cloud-builds)
# Not used if using Felgo Live
PRODUCT_LICENSE_KEY = "FEA9C659E7AE0510A88220EFB1E3632B5AE2A51328220BDAEC2542A659A4368339833A77AEEAD0C7CB021848F209B97EC902DEF2F9AF05C36A6C133776EC5693FAC17B81E75A6045596E927BBA91C6448A430B7D8D68ABA8A7B3742C1CDE6991F690664C4F208EF36F41711BEF352E71DD2B957DADF9FDCCBFAB9B227A450C574675BF9147B5A65BAE751AA9F8BF72A09BFF9BE4490DA66330AEE704FE6A31D8378578472F30F78EC4AB616446700465FF0C0B978638414EE4867721C4AFEFD43E6EFD1BAF98F7708C8F5770BBDC2E44B192DD715324955ECDC8D57B3C3078234ECE2555FA6567D7AA0F774FA7A0158ACB06AC16B27E681F7D3589A467DF0D40E270E81FCBE35185166BFB47DD3282C86507CBC8B0ABF8A7A8E6F3BAC9D120BAE44E9A60EC7397971997B4728A89CC4B16E9CF66117D2336A6A011919FDBDBB45628A7E5F90B74270E17C23802A20E6E"


qmlFolder.source = qml
DEPLOYMENTFOLDERS += qmlFolder # comment for publishing

assetsFolder.source = assets
DEPLOYMENTFOLDERS += assetsFolder

# Add more folders to ship with the application here

RESOURCES += #    resources.qrc # uncomment for publishing

# NOTE: for PUBLISHING, perform the following steps:
# 1. comment the DEPLOYMENTFOLDERS += qmlFolder line above, to avoid shipping your qml files with the application (instead they get compiled to the app binary)
# 2. uncomment the resources.qrc file inclusion and add any qml subfolders to the .qrc file; this compiles your qml files and js files to the app binary and protects your source code
# 3. change the setMainQmlFile() call in main.cpp to the one starting with "qrc:/" - this loads the qml files from the resources
# for more details see the "Deployment Guides" in the Felgo Documentation

# during development, use the qmlFolder deployment because you then get shorter compilation times (the qml files do not need to be compiled to the binary but are just copied)
# also, for quickest deployment on Desktop disable the "Shadow Build" option in Projects/Builds - you can then select "Run Without Deployment" from the Build menu in Qt Creator if you only changed QML files; this speeds up application start, because your app is not copied & re-compiled but just re-interpreted


# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp


android {
    ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android
    OTHER_FILES += android/AndroidManifest.xml       android/build.gradle
}

ios {
    QMAKE_INFO_PLIST = ios/Project-Info.plist
    OTHER_FILES += $$QMAKE_INFO_PLIST
}

# set application icons for win and macx
win32 {
    RC_FILE += win/app_icon.rc
}
macx {
    ICON = macx/app_icon.icns
}

DISTFILES += \
    ItemWithChartboost.qml \
    code-chartboost.png \
    logo-chartboost.png
