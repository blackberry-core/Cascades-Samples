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
#include "NfcReceiver.hpp"
#include "NfcSender.hpp"
#include "NfcShareHandler.hpp"

#include <bb/cascades/AbstractPane>
#include <bb/cascades/Application>
#include <bb/cascades/QmlDocument>
#include <bb/cascades/pickers/FilePicker>
#include <bb/cascades/pickers/FileType>

#include <QLocale>
#include <QTranslator>

using namespace bb::cascades;

Q_DECL_EXPORT int main(int argc, char **argv)
{
    Application app(argc, argv);

    // localization support
    QTranslator translator;
    const QString locale_string = QLocale().name();
    const QString filename = QString::fromLatin1("nfcdemo_%1").arg(locale_string);
    if (translator.load(filename, "app/native/qm")) {
        app.installTranslator(&translator);
    }
    qmlRegisterUncreatableType<NfcShareHandler>("custom", 1, 0, "NfcShareHandler", "Access to enums");
    qmlRegisterType<bb::cascades::pickers::FilePicker>("custom", 1, 0, "FilePicker");
    qmlRegisterUncreatableType<bb::cascades::pickers::FileType>("custom", 1, 0, "FileType", "Access to enums");
    qmlRegisterType<FileListModel>();
//! [0]
    QmlDocument *qml = QmlDocument::create("asset:///main.qml").parent(&app);
    qml->setContextProperty("_macAddressHandler", new MacAddressHandler(&app));
    qml->setContextProperty("_nfcReceiver", new NfcReceiver(&app));
    qml->setContextProperty("_nfcSender", new NfcSender(&app));
    qml->setContextProperty("_nfcShareHandler", new NfcShareHandler(&app));
//! [0]
    AbstractPane *root = qml->createRootObject<AbstractPane>();
    Application::instance()->setScene(root);

    return Application::exec();
}
