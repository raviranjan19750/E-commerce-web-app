
// Get Function Secret key Firebase remote config

function secret_key() {
    const remoteConfig = firebase.remoteConfig();

    remoteConfig.settings.minimumFetchIntervalMillis = 3600000;

    return remoteConfig.fetchAndActivate()
        .then(() => {
            const val = remoteConfig.getValue("function_secret_key");

            return val._value;
        })
        .catch((err) => {
            console.error({ err })
        });
}