monkey = require '../src/tree-monkey'

describe 'traverse tree', ->
  tree = {
    'a': { 'aa': 42 }
    'b': {
      'ba': "leaf",
      'bb': { 'bba': [] }
    }
  }

  allPaths = ['', '/a', '/b', '/b/ba', '/b/bb', '/a/aa', '/b/bb/bba']

  treeFunction = null

  beforeEach ->
    # simulate async with a random timeout between 1ms and 100ms
    treeFunction = jasmine.createSpy().andCallFake (node, path, callback) ->
      setTimeout callback, Math.round(Math.random() * 100)

  it 'should traverse a tree pre order', ->
    done = false

    runs ->
      monkey.preOrder tree, treeFunction, -> done = true
    waitsFor -> done

    runs ->
      expect(treeFunction.calls.length).toBe allPaths.length

      # collect all paths in the order they were called
      paths = []
      paths.push call.args[1] for call in treeFunction.calls

      # make sure every single path has been visited
      for path in allPaths
        index = paths.indexOf(path)
        console.log path  unless index > -1
        expect(index).toBeGreaterThan(-1)

      # check that pre-order is maintained, i.e parent nodes are
      # called before their children
      expect(paths.indexOf('')).toBeLessThan paths.indexOf('/a')
      expect(paths.indexOf('')).toBeLessThan paths.indexOf('/b')
      expect(paths.indexOf('/a')).toBeLessThan paths.indexOf('/a/aa')
      expect(paths.indexOf('/b')).toBeLessThan paths.indexOf('/b/ba')
      expect(paths.indexOf('/b')).toBeLessThan paths.indexOf('/b/bb')
      expect(paths.indexOf('/b/bb')).toBeLessThan paths.indexOf('/b/bb/bba')

  it 'should traverse a tree post order', ->
    done = false

    runs ->
      monkey.postOrder tree, treeFunction, -> done = true
    waitsFor -> done

    runs ->
      expect(treeFunction.calls.length).toBe allPaths.length

      # collect all paths in the order they were called
      paths = []
      paths.push call.args[1] for call in treeFunction.calls

      # make sure every single path has been visited
      for path in allPaths
        index = paths.indexOf(path)
        console.log path  unless index > -1
        expect(index).toBeGreaterThan(-1)

      # check that post-order is maintained, i.e parent nodes are
      # called after their children
      expect(paths.indexOf('')).toBeGreaterThan paths.indexOf('/a')
      expect(paths.indexOf('')).toBeGreaterThan paths.indexOf('/b')
      expect(paths.indexOf('/a')).toBeGreaterThan paths.indexOf('/a/aa')
      expect(paths.indexOf('/b')).toBeGreaterThan paths.indexOf('/b/ba')
      expect(paths.indexOf('/b')).toBeGreaterThan paths.indexOf('/b/bb')
      expect(paths.indexOf('/b/bb')).toBeGreaterThan paths.indexOf('/b/bb/bba')

  it 'should not require a final callback', ->
    expect( ->
      monkey.postOrder tree, (_, __, callback) -> callback()
    ).not.toThrow()
