AdncTools.RESTAdapter = DS.RESTAdapter.extend({
  namespace: 'api/v1'
});

//AdncTools.RESTAdapter.map('AdncTools.Test');

AdncTools.Store = DS.Store.extend({
  revision: 12,
  adapter: AdncTools.RESTAdapter
});