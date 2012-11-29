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

#include "MacAddressHandler.hpp"

#include <QtCore/QDebug>

#include <bps/bps.h>

MacAddressHandler::MacAddressHandler(QObject *parent)
    : QObject(parent)
    , m_macAddress(tr("<not set>"))
{
    initialize();
}

MacAddressHandler::~MacAddressHandler()
{
    nfc_unregister_handover_listener();
    nfc_stop_events();
    unsubscribe(nfc_get_domain());
    bps_shutdown();
}

QString MacAddressHandler::macAddress() const
{
    return m_macAddress;
}

void MacAddressHandler::event(bps_event_t *event)
{
    uint16_t code = bps_event_get_code(event);
    nfc_event_t *nfc_event = 0;

    if (nfc_get_nfc_event(event, &nfc_event) != BPS_SUCCESS) {
        qDebug() << "[ERRO] Get NFC event: BPS_FAILURE" << endl;
    }

    nfc_target_t *target = 0;
    nfc_get_target(nfc_event, &target);

    switch(code) {
        case NFC_HANDOVER_DETECTED_EVENT: {
            qDebug() << "[INFO] Received NFC_HANDOVER_DETECTED_EVENT" << endl;
            handleNfcHandoverDetectedEvent(target);
        }
        break;
        case NFC_HANDOVER_COMPLETE_EVENT: {
            handleNfcHandoverCompletedEvent(target);
            qDebug() << "[INFO] Received NFC_HANDOVER_COMPLETE_EVENT" << endl;
        }
        break;
        default: {
            qDebug() << "[WARN] Event not handled: " << code << endl;
        }
        break;
    }

    nfc_destroy_target(target);
}
//! [0]
void MacAddressHandler::initialize()
{
    bps_initialize();
    subscribe(nfc_get_domain());

    const int rc = nfc_request_events();
    if (rc == NFC_RESULT_SUCCESS) {
        qDebug() << "[INFO] Request NFC Events: NFC_RESULT_SUCCESS" << endl;
    } else {
        nfc_stop_events();
        unsubscribe(nfc_get_domain());
        bps_shutdown();
        qDebug() << "[ERRO] Request NFC Events: NFC_RESULT_FAILURE" << endl;
    }

    nfc_register_handover_listener(BLUETOOTH_HANDOVER);
}
//! [0]
//! [1]
void MacAddressHandler::handleNfcHandoverDetectedEvent(nfc_target_t *target)
{
    nfc_confirm_handover_process(target, true);
    qDebug() << "[INFO] Confirmed Handover" << endl;
}

void MacAddressHandler::handleNfcHandoverCompletedEvent(nfc_target_t *target)
{
    handover_transport_type_t transport;
    nfc_get_handover_transport(target, &transport);

    nfc_bluetooth_handover_data_t bluetooth_data;
    nfc_get_bluetooth_handover_data(target, &bluetooth_data);

    // The MAC address is in little-endian order
    const unsigned char *macAddr = bluetooth_data.mac_address;

    m_macAddress.sprintf("%02x:%02x:%02x:%02x:%02x:%02x", (unsigned int) macAddr[5],
                        (unsigned int) macAddr[4], (unsigned int) macAddr[3],
                        (unsigned int) macAddr[2], (unsigned int) macAddr[1],
                        (unsigned int) macAddr[0]);

    emit macAddressChanged();
    qDebug() << "[INFO] MAC ADDRESS: " << m_macAddress << endl;
}
//! [1]
