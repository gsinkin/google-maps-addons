$ = jQuery

testContains = (coords, point, expected) ->
  polygon = new google.maps.Polygon({
    paths: coords,
  });
  return polygon.Contains(point) == expected

results = {total: 0, tests: []}

testVertex = () ->
  # this shiz complex, yo. Check the wiki entry on point-in-polygon for vertex calcs
  triangleCoords = [
    new google.maps.LatLng(25.774252, -80.190262),
    new google.maps.LatLng(18.466465, -66.118292),
    new google.maps.LatLng(32.321384, -64.75737),
    new google.maps.LatLng(25.774252, -80.190262)
  ]
  point = triangleCoords[1]
  if !testContains triangleCoords, point, true
    console.log "testVertex Expected true but got false"
    results.tests.push {name: "testVertex", result: "fail"}
  else
    results.tests.push {name: "testVertex", result: "pass"}
  results.total++

testMiddle = () ->
  triangleCoords = [
    new google.maps.LatLng(25.774252, -80.190262),
    new google.maps.LatLng(18.466465, -66.118292),
    new google.maps.LatLng(32.321384, -64.75737),
    new google.maps.LatLng(25.774252, -80.190262)
  ]
  middle = new google.maps.LatLng(25.3939245, -72.473816)
  if !testContains triangleCoords, middle, true
    console.log "testMiddle Expected true but got false"
    results.tests.push {name: "testMiddle", result: "fail"}
  else
    results.tests.push {name: "testMiddle", result: "pass"}
  results.total++

$.fn.runTests = () ->
  testVertex()
  testMiddle()
  return results
