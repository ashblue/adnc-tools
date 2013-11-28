//# http://emberjs.com/guides/models/using-the-store/

AdncTools.RESTAdapter = DS.RESTAdapter.extend({
    namespace: 'api/v1'
});

AdncTools.Store = DS.Store.extend({
    revision: 12,
    adapter: AdncTools.RESTAdapter
});

//
//AdncTools.RESTAdapter = DS.RESTAdapter.extend
//  serializer: DS.RESTSerializer.extend
//    primaryKey: function ()
//
//AdncTools.Store = DS.Store.extend
//  # Override the default adapter with the `DS.ActiveModelAdapter` which
//  # is built to work nicely with the ActiveModel::Serializers gem.
//  adapter: '_ams'
//
//#AdncTools.Store = DS.RESTAdapter.extend
//#  # Override the default adapter with the `DS.ActiveModelAdapter` which
//#  # is built to work nicely with the ActiveModel::Serializers gem.
//#  namespace: 'node'