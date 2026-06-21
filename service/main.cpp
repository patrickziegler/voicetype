#include <sdbus-c++/sdbus-c++.h>

#include <cstdint>
#include <iostream>
#include <memory>
#include <string>

class VoiceTypeService
{
public:
    VoiceTypeService()
    : connection_(sdbus::createSessionBusConnection())
    , object_(sdbus::createObject(*connection_, "/org/kde/VoiceType"))
    {
        connection_->requestName("org.kde.VoiceType");

        registerMethods();
        registerProperties();

        object_->finishRegistration();
    }

    void run()
    {
        connection_->enterEventLoop();
    }

private:
    enum Status : uint32_t
    {
        Idle = 0,
        LoadingModel = 1,
        WaitingForActivation = 2,
        Recording = 3,
        Transcribing = 4,
        InsertingText = 5,
        Error = 6
    };

    void registerMethods()
    {
        object_->registerMethod("StartRecording")
        .onInterface("org.kde.VoiceType")
        .implementedAs([this]() {
            std::cout << "StartRecording()" << std::endl;

            status_ = Recording;
            text_.clear();

            emitPropertyChanged("Status");
            emitPropertyChanged("Text");
        });

        object_->registerMethod("StopRecording")
        .onInterface("org.kde.VoiceType")
        .implementedAs([this]() {
            std::cout << "StopRecording()" << std::endl;

            status_ = Idle;
            text_ = "Dummy transcription result";

            emitPropertyChanged("Status");
            emitPropertyChanged("Text");
        });
    }

    void registerProperties()
    {
        object_->registerProperty("VoiceActivation")
        .onInterface("org.kde.VoiceType")
        .withGetter([this]() {
            return voiceActivation_;
        })
        .withSetter([this](const bool& value) {
            voiceActivation_ = value;
            emitPropertyChanged("VoiceActivation");
        });

        object_->registerProperty("Language")
        .onInterface("org.kde.VoiceType")
        .withGetter([this]() {
            return language_;
        })
        .withSetter([this](const std::string& value) {
            language_ = value;
            emitPropertyChanged("Language");
        });

        object_->registerProperty("Status")
        .onInterface("org.kde.VoiceType")
        .withGetter([this]() {
            return status_;
        });

        object_->registerProperty("Text")
        .onInterface("org.kde.VoiceType")
        .withGetter([this]() {
            return text_;
        });

        object_->registerProperty("Provider")
        .onInterface("org.kde.VoiceType")
        .withGetter([this]() {
            return provider_;
        });

        object_->registerProperty("MaximumRecordingDurationSeconds")
        .onInterface("org.kde.VoiceType")
        .withGetter([this]() {
            return maximumRecordingDurationSeconds_;
        });
    }

    void emitPropertyChanged(const std::string& property)
    {
        object_->emitPropertiesChangedSignal(
            "org.kde.VoiceType",
            {property});
    }

private:
    std::unique_ptr<sdbus::IConnection> connection_;
    std::unique_ptr<sdbus::IObject> object_;

    bool voiceActivation_ = true;
    std::string language_ = "en-US";

    uint32_t status_ = Idle;

    std::string text_;
    std::string provider_ = "Dummy Provider";

    uint32_t maximumRecordingDurationSeconds_ = 30;
};

int main()
{
    try
    {
        VoiceTypeService service;
        service.run();
    }
    catch (const std::exception& e)
    {
        std::cerr << "Fatal error: " << e.what() << std::endl;
        return 1;
    }

    return 0;
}
