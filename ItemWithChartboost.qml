import Felgo 3.0
import QtQuick 2.0

/*/////////////////////////////////////
  NOTE:
  Additional integration steps are needed to use the plugin, for example to add and link required libraries for Android and iOS.
  Please follow the integration steps described in the plugin documentation: https://felgo.com/doc/plugin-chartboost/


  EXAMPLE USAGE:
  Add the following piece of code inside your main QML { } to display this example page.

  ItemWithChartboost {

  }

/////////////////////////////////////*/

Rectangle {
    anchors.fill: parent

    // Plugin Item
    Chartboost {
        id: chartboost
        property bool rewardReady: false

        // replace this configuration with your Chartboost appId and appSignature
        appId: Theme.isIos ? "53609edd89b0bb726b46c6e0" : "53609f3789b0bb72b4b95836"
        appSignature: Theme.isIos ? "6fed94ffeaf6abb3d5aa85781e59fa2fb83354b8" : "c87b4e51a85b76a4bbe41ee880634fc9ae875ca8"

        onRewardedVideoCached: {
            rewardReady = true
            console.debug("Rewarded Video was cached!")
            NativeDialog.confirm("Rewarded Video Cached", "Rewarded Video is now cached.", function() {}, false)
        }

        onInterstitialCached: {
            console.log("Interstitial Cached for " + location + " or locationType: " + locationType)
            if(locationType === Chartboost.HomeScreenLocation) {
                console.log("Interstitial cached for HomeScreen")
            }
            NativeDialog.confirm("Interstitial Cached", "Interstitial is now cached.", function() {}, false)
        }

        // handle failed to load
        onRewardedVideoFailedToLoad: NativeDialog.confirm("Rewarded Video Failed", "Rewarded Video failed to load.", function() {}, false)
        onInterstitialFailedToLoad: NativeDialog.confirm("Interstitial Failed", "Interstitial failed to load.", function() {}, false)

        shouldRequestInterstitialsInFirstSession: true
    }

    // AppListView for Plugin Overview and Example Usage
    AppListView {
        id: listView
        anchors.fill: parent
        backgroundColor: parent.color

        // Plugin Overview
        header: Column {
            id: contentCol
            width: parent.width
            spacing: dp(16)

            // Description Text
            Rectangle {
                width: parent.width
                height: descriptionText.height + 2 * contentCol.spacing
                color: "lightgrey"
                AppText {
                    id: descriptionText
                    width: parent.width - 2 * contentCol.spacing
                    text: "Integrate with Chartboost to monetize and cross-promote your games with ads."
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    horizontalAlignment: Text.AlignHCenter
                    anchors.centerIn: parent
                }
            }

            // Image of Code Sample
            Image {
                width: sourceSize.width * dp(1) * 0.75
                height: width / sourceSize.width * sourceSize.height
                source: Qt.resolvedUrl("code-chartboost.png")
                anchors.horizontalCenter: parent.horizontalCenter
            }

            // Image of Plugin Logo
            Image {
                width: sourceSize.width * dp(1) * 0.5
                height: width / sourceSize.width * sourceSize.height
                source: Qt.resolvedUrl("logo-chartboost.png")
                anchors.horizontalCenter: parent.horizontalCenter
            }

            // Example Headline
            Rectangle {
                width: parent.width
                height: exampleHeadline.height + 2 * contentCol.spacing
                color: "lightgrey"
                AppText {
                    id: exampleHeadline
                    width: parent.width - 2 * contentCol.spacing
                    text: "Example"
                    horizontalAlignment: Text.AlignHCenter
                    anchors.centerIn: parent
                }
            }
        }

        // Example Actions (Content of List)
        model: ListModel {
            ListElement { section: "Interstitial"; name: "Load and show" }
            ListElement { section: "Interstitial"; name: "Cache interstitial" }
            ListElement { section: "Interstitial"; name: "Show Interstitial" }
            ListElement { section: "Rewarded Video"; name: "Cache Video" }
            ListElement { section: "Rewarded Video"; name: "Show Video" }
            ListElement { section: "More"; name: "Load and show" }
        }

        // Styling of ListView Delegate (List Items)
        delegate: SimpleRow {
            id: row
            text: name

            // Execute selected Action for plugin when list item is clicked
            onSelected: {
                // Interstitial
                if (index === 0) {
                    chartboost.showInterstitial()
                } else if (index === 1) {
                    chartboost.cacheInterstitial(Chartboost.HomeScreenLocation)
                } else if(index === 2) {
                    chartboost.showInterstitial(Chartboost.HomeScreenLocation)
                } else if(index === 3) {
                    chartboost.cacheRewardedVideo(Chartboost.DefaultLocation)
                } else if (index === 4) {
                    chartboost.showRewardedVideo(Chartboost.DefaultLocation)
                } else if (index === 5) {
                    chartboost.showMoreApps(Chartboost.DefaultLocation)
                }
            }
        }

        // Styling of List Sections
        section.property: "section"
        section.delegate: SimpleSection { }
    }
}
