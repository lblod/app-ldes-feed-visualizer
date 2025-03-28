export default [
    {
        match: {
            subject: {},
        },
        callback: {
            url: "http://resource/.mu/delta",
            method: "POST",
        },
        options: {
            resourceFormat: "v0.0.1",
            gracePeriod: 1000,
            foldEffectiveChanges: true,
            ignoreFromSelf: true,
        },
    },
    {
        match: {
            predicate: { type: 'uri', value: 'http://purl.org/dc/terms/isVersionOf' }
        },
        callback: {
            url: "http://make-object/delta",
            method: "POST"
        },
        options: {
            resourceFormat: "v0.0.1",
            gracePeriod: 500,
            ignoreFromSelf: true
        }
    }
];
