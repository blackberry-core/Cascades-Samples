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

#ifndef MACADDRESSHANDLER_HPP
#define MACADDRESSHANDLER_HPP

#include <QObject>

#include <bb/AbstractBpsEventHandler>
#include <nfc/nfc_bps.h>

/*!
 * @brief A helper object that encapsulates the code to detect the MAC address.
 */
class MacAddressHandler : public QObject, public bb::AbstractBpsEventHandler
{
    Q_OBJECT

    // A property to make the MAC address available to the UI
    Q_PROPERTY(QString macAddress READ macAddress NOTIFY macAddressChanged)

public:
    /**
     * Creates a new MAC address handler.
     *
     * @param parent The parent object.
     */
    MacAddressHandler(QObject *parent = 0);

    /**
     * Destroys the MAC address handler.
     */
    virtual ~MacAddressHandler();

    // Reimplemented from bb::AbstractBpsEventHandler, is called whenever a BPS event is received.
    virtual void event(bps_event_t *event);

Q_SIGNALS:
    // The change notification signal of the property
    void macAddressChanged();

private:
    // The getter method of the property
    QString macAddress() const;

    // Initializes the connection to the NFC stack
    void initialize();

    // This method is called whenever a NFC handover detected event is received
    void handleNfcHandoverDetectedEvent(nfc_target_t *target);

    // This method is called whenever a NFC handover completed event is received
    void handleNfcHandoverCompletedEvent(nfc_target_t *target);

    // The detected MAC address
    QString m_macAddress;
};

#endif
