# stolen from http://econym.org.uk/gmap/epoly.js - uses ray tracing
if !google.maps.Polygon.prototype.Contains
  google.maps.Polygon.prototype.Contains = (point) ->
    j = 0
    oddNodes = false
    x = point.lng()
    y = point.lat()
    latLngs = this.latLngs.getArray()[0]
    i = 0
    while i < latLngs.length
      j++
      if j == latLngs.length
        j = 0
      if ((latLngs.getAt(i).lat() < y and latLngs.getAt(j).lat() >= y) or (latLngs.getAt(j).lat() < y and latLngs.getAt(i).lat() >= y)) and (latLngs.getAt(i).lng() + (y - latLngs.getAt(i).lat()) / (latLngs.getAt(j).lat() - latLngs.getAt(i).lat()) * (latLngs.getAt(j).lng() - latLngs.getAt(i).lng()) < x)
        oddNodes = !oddNodes
      i++
    return oddNodes

# stolen from https://trac.osgeo.org/postgis/wiki/UserWikiRandomPoint
if !google.maps.Polygon.prototype.randomInternalLatLng
  google.maps.Polygon.prototype.randomInternalLatLng = () ->
    latLngs = this.latLngs.getArray()[0].b
    xs = (ll.lb for ll in latLngs)
    ys = (ll.mb for ll in latLngs)
    x0 = Math.min.apply(null, xs)
    dx = Math.max.apply(null, xs) - x0
    y0 = Math.min.apply(null, ys)
    dy = Math.max.apply(null, ys) - y0

    generatePoint = () ->
      xp = Math.random() * dx + x0
      yp = Math.random() * dy + y0
      return new google.maps.LatLng(xp, yp)
    point = generatePoint()
    while !this.Contains(point)
      point = generatePoint()
    return point
