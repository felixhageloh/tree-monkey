async = require 'async'

preOrderTraverser = (visitNode) ->
  visitBranch = (node, path, callback) ->
    async.series [
      visitNode(node, path),
      visitChildren(node, path, visitBranch)
    ], callback

postOrderTraverser = (visitNode) ->
  visitBranch = (node, path, callback) ->
    async.series [
      visitChildren(node, path, visitBranch),
      visitNode(node, path)
    ], callback

isBranch = (node) ->
  '[object Object]' == Object::toString.call(node)

visitChildren = (node, path, visitBranch) -> (callback) ->
  visitorFunctions = []

  if isBranch node
    for name, child of node
      do (name, child) ->
        visitorFunctions.push (done) ->
          visitBranch child, path+'/'+name, done

  async.parallel visitorFunctions, callback

# care for some curry with that?
visitNode = (nodeFunction) -> (node, path) -> (callback) ->
  nodeFunction node, path, callback


# visits all nodes depth-first in async pre-order, meaning each parent node
# is visited before its child nodes and then all child nodes are visited
# asynchrounously. This means all branches are visited in their own speed,
# so to say, and we can't know the order in which they will complete.
exports.preOrder = (rootNode, nodeFunction, callback) ->
  preOrderTraverser(visitNode(nodeFunction))(rootNode, '', callback)


# visits all nodes depth-first in async prost-order, meaning children will
# be visited before their parent node. Child nodes are visited
# asynchrounously, meaning we can't know the order in which they will
# complete.
exports.postOrder = (rootNode, nodeFunction, callback) ->
  postOrderTraverser(visitNode(nodeFunction))(rootNode, '', callback)