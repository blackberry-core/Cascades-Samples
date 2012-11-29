/* Copyright (c) 2012 Research In Motion Limited.
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
* http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*/

import bb.cascades 1.0

Page {
    id: root

    titleBar: TitleBar {
        title: qsTr ("Message Details")
    }

    Container {
        layout: DockLayout {}

        // The background image
        ImageView {
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Fill

            imageSource: "asset:///images/background.png"
        }

        Container {
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Fill

            leftPadding: 30
            topPadding: 30
            rightPadding: 30

            Container {
                horizontalAlignment: HorizontalAlignment.Fill

                leftPadding: 10
                topPadding: 30
                rightPadding: 30
                bottomPadding: 10

                background: Color.create("#22000000")

                Label {
                    text: _messages.messageViewer.subject
                    textStyle {
                        base: SystemDefaults.TextStyles.BigText
                    }
                }

                Container {
                    horizontalAlignment: HorizontalAlignment.Fill

                    layout: StackLayout {
                        orientation: LayoutOrientation.LeftToRight
                    }

//! [0]
                    Label {
                        verticalAlignment: VerticalAlignment.Bottom

                        text: _messages.messageViewer.sender
                        textStyle {
                            base: SystemDefaults.TextStyles.TitleText
                        }
                    }
//! [0]

                    Label {
                        horizontalAlignment: HorizontalAlignment.Right
                        verticalAlignment: VerticalAlignment.Bottom

                        text: qsTr ("(%1)").arg(_messages.messageViewer.time)
                        textStyle {
                            base: SystemDefaults.TextStyles.SmallText
                            textAlign: TextAlign.Right
                        }
                    }
                }
            }

            Container {
                horizontalAlignment: HorizontalAlignment.Fill

                topMargin: 30

                leftPadding: 30
                topPadding: 30
                rightPadding: 30
                bottomPadding: 30

                background: Color.create("#11000000")

                ScrollView {
                    scrollViewProperties {
                        scrollMode: ScrollMode.Vertical
                    }

                    Label {
                        text: _messages.messageViewer.body
                        multiline: true
                    }
                }
            }
        }
    }

//! [1]
    actions: [
        ActionItem {
            title: qsTr ("Reply")
            imageSource: "asset:///images/action_replymessage.png"

            onTriggered: {
                _messages.composeReplyMessage()
                navigationPane.push(messageComposer.createObject())
            }
        },
        DeleteActionItem {
            onTriggered: {
                _messages.deleteMessage()

                navigationPane.pop()
            }
        }
    ]
//! [1]

//! [2]
    attachedObjects: [
        ComponentDefinition {
            id: messageComposer
            source: "MessageComposer.qml"
        }
    ]
//! [2]
}
