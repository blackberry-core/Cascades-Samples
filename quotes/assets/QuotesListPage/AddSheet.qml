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

// The Edit Screen is where the text areas for editing and completing information for a new
// record is added together with two buttons for add/edit and cancel.

Sheet {
    id: addSheet
    signal addNewRecord(string firstName, string lastName, string quote)
    
    Page {
        id: addPage
        
        titleBar: TitleBar {
            id: addBar
            title: "Add"
            visibility: ChromeVisibility.Visible
            
            dismissAction: ActionItem {
                title: "Cancel"
                onTriggered: {
                    addSheet.close()
                }
            }
            
            acceptAction: ActionItem {
                title: "Save"
                enabled: false
                onTriggered: {
                    addNewRecord(firstNameField.text, lastNameField.text, quoteField.text);
                    addSheet.close()
                }
            }
        } // TitleBar
        
        Container {
            id: editPane
            property real margins: 40
            
            background: Color.create("#f8f8f8")
            topPadding: editPane.margins
            leftPadding: editPane.margins
            rightPadding: editPane.margins
            
            layout: DockLayout {
            }
            
            Container {
                layout: StackLayout {
                }

                // The quote text area
                TextArea {
                    id: quoteField
                    hintText: "Quote"
                    bottomMargin: editPane.margins
                    enabled: false
                    preferredHeight: 450
                    maxHeight: 450
                    horizontalAlignment: HorizontalAlignment.Fill
                }
                
                Container {
                    layout: StackLayout {
                        orientation: LayoutOrientation.LeftToRight
                    }

                    // Text field for the first name
                    TextField {
                        id: firstNameField
                        hintText: "First name"
                        enabled: false
                    }

                    // Text field for the last name
                    TextField {
                        id: lastNameField
                        hintText: "Last name"
                        
                        onTextChanging: {

                            // A last name has to be entered disable buttons and text areas as long as the length is zero.
                            if (text.length > 0) {
                                addPage.titleBar.acceptAction.enabled = true;
                                quoteField.enabled = true;
                                firstNameField.enabled = true;
                            } else {
                                addPage.titleBar.acceptAction.enabled = false;
                                quoteField.enabled = false;
                                firstNameField.enabled = false;
                            }
                        }
                    }//Last name text field
                } // Name text Container
            } //Total text Container (name text + quote text)
        } // Content Container
    }
}
