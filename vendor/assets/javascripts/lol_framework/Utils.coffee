Lol.Utils =
  uniqidSeed: 1
  uniqid: (prefix='', more_entropy)->
    # +   original by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
    # +    revised by: Kankrelune (http://www.webfaktory.info/)
    # %        note 1: Uses an internal counter (in php_js global) to avoid collision
    # *     example 1: uniqid();
    # *     returns 1: 'a30285b160c14'
    # *     example 2: uniqid('foo');
    # *     returns 2: 'fooa30285b1cd361'
    # *     example 3: uniqid('bar', true);
    # *     returns 3: 'bara20285b23dfd1.31879087'
    formatSeed = (seed, reqWidth)->
      seed = parseInt(seed, 10).toString(16)
      return seed.slice(seed.length - reqWidth) if reqWidth < seed.length
      return Array(1 + (reqWidth - seed.length)).join('0') + seed if reqWidth > seed.length
      seed

    @uniqidSeed = Math.floor(Math.random() * 0x75bcd15) if not @uniqidSeed
    @uniqidSeed++

    retId = prefix
    retId += formatSeed(parseInt(new Date().getTime() / 1000, 10), 8)
    retId += formatSeed(@uniqidSeed, 5)
    retId += (Math.random() * 10).toFixed(8).toString() if more_entropy
    retId

  # Convert to string
  toString: (obj)->
    new String(obj)

  # Add references objects
  _object_id: {}
  addObject: (obj)->
  	@_object_id[obj.id] = obj
  getObject: (id)->
  	@_object_id[id]
  removeObject: (id)->
    @_object_id[id] = null
  redirector: (url)->
    window.location = url

