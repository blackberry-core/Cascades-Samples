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

//![0]
// This container lays out visual components of a mock weather application
Container {
    horizontalAlignment: HorizontalAlignment.Fill
    leftPadding: 30
    rightPadding: 30

    Container {
        horizontalAlignment: HorizontalAlignment.Fill
        topPadding: 50
        Label {
            horizontalAlignment: HorizontalAlignment.Left
            text: qsTr("Current Weather")
            textStyle {
                base: SystemDefaults.TextStyles.BigText
                fontWeight: FontWeight.Bold
            }
        }
        Label {
            horizontalAlignment: HorizontalAlignment.Right
            text: qsTr("Friday, October 5, 2012, 16:19 EDT")
            textStyle {
                base: SystemDefaults.TextStyles.SmallText
            }
        }
    }

    Container {
        leftPadding: 100

        ImageView {
            id: imgTab1
            imageSource: "asset:///images/sun.png"
            verticalAlignment: VerticalAlignment.Bottom
            horizontalAlignment: HorizontalAlignment.Left
            scalingMethod: ScalingMethod.AspectFit
        }

        LabeledLabel {
            tag: qsTr("Feels Like: ")
            text: qsTr("20")
        }
        LabeledLabel {
            tag: qsTr("Wind: ")
            text: qsTr("W 31 km/h")
        }
        LabeledLabel {
            tag: qsTr("Wind Gusts: ")
            text: qsTr("52 km/h")
        }
        LabeledLabel {
            tag: qsTr("Sunrise: ")
            text: qsTr("7:36")
        }
        LabeledLabel {
            tag: qsTr("Sunset: ")
            text: qsTr("18:36")
        }
    }
}
//! [0]
