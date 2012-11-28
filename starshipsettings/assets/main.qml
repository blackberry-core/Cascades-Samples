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
    
    // Content Container
    Container {
        topPadding: 175
        background: backgroundPaint.imagePaint
        
        attachedObjects: [
            ImagePaintDefinition {
                id: backgroundPaint
                imageSource: "asset:///images/Background.png"
            }
        ]

        // Top Container with a RadioButtonGroup and title
        Container {
            preferredWidth: 545
            horizontalAlignment: HorizontalAlignment.Center
            
            Label {
                bottomMargin: 0
                horizontalAlignment: HorizontalAlignment.Left
                text: "DIVERT ALL POWER TO:"
                
                textStyle {
                    base: SystemDefaults.TextStyles.SmallText
                    fontWeight: FontWeight.Bold
                    color: Color.create("#ff262626")
                }
            }
            
            RadioGroup {
                id: radioGroup1
                objectName: "radioGroup1"

                // Button 1
                Option {
                    id: radioGroupOption0
                    objectName: "radioGroupOption0"
                    text: "HYPERDRIVE"

                    // Call our C++ getValueFor() function for objectName, which connects to the QSettings.
                    selected: _starshipApp.getValueFor(objectName, "false")
                    
                    onSelectedChanged: {
                        _starshipApp.saveValueFor(radioGroupOption0.objectName, radioGroupOption0.selected)
                    }
                }
                
                // Button 2
                Option {
                    id: radioGroupOption2
                    objectName: "radioGroupOption2"
                    text: "SAUNA"

                    // Call our C++ getValueFor() function for objectName, which connects to the QSettings.
                    selected: _starshipApp.getValueFor(objectName, "true")
                    
                    onSelectedChanged: {
                        _starshipApp.saveValueFor(radioGroupOption2.objectName, radioGroupOption2.selected)
                    }
                }
            } // RadioGroup
        } // Top Container

        // This is our custom component with warp-core image, slider with title, and tooltip
        // which is based from Container in WarpDrive.qml.
        WarpDrive {
            leftPadding: 110
            rightPadding: leftPadding
        }

        // Bottom Container with custom CheckBox and ToggleButton
        Container {
            preferredWidth: 545
            horizontalAlignment: HorizontalAlignment.Center
            
            CheckBox {
                id: uranuscanner
                text: "URANUS SCANNER"
                objectName: "uranuscanner"
                checked: _starshipApp.getValueFor(objectName, "yes")
                onCheckedChanged: {
                    _starshipApp.saveValueFor(uranuscanner.objectName, checked)
                }
            }
            
            Label {
                horizontalAlignment: HorizontalAlignment.Center
                text: "GRAVITY"
                
                textStyle {
                    base: SystemDefaults.TextStyles.BodyText
                    color: Color.create("#ff262626")
                }
            }
            
            ToggleButton {
                id: gravity
                checked: _starshipApp.getValueFor(objectName, "false")
                objectName: "gravity"
                horizontalAlignment: HorizontalAlignment.Center
                
                onCheckedChanged: {
                    _starshipApp.saveValueFor(gravity.objectName, checked)
                }
            }
        }// Bottom Container
    }// Content Container
}// Page
