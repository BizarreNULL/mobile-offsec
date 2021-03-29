setTimeout(function () {
    Java.perform(function () {
        console.log("Loading TrustManagerImpl class");
        try {
            var trustManagerImpl = Java.use('com.android.org.conscrypt.TrustManagerImpl');
            trustManagerImpl.verifyChain.implementation = function (untrustedChain, trustAnchorChain, host, clientAuth, ocspData, tlsSctData) {
                console.log("TrustManagerImpl verifyChain() called to host " + host + ". Returning untrustedChain.");
                return untrustedChain;
            }
        }
        catch (err) {
            console.error(err);
        }
    }
}, 0);