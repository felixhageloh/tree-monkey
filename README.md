Async tree traversal for nodejs
===============================

***under development!***

<tt>tree-monkey</tt> takes a JSON or object literal tree of the form

```JavaScript
{
  "nodeA": {
    "nodeAA": {
      "nodeAAA": {}
    }
  },
  "nodeB": {
    "nodeBA": {}
    "nodeBB": {}
  }
}
```

and traversers it asynchronously.


## Usage

The basic usage is as follows:

```JavaScript
var monkey = require('tree-monkey')
  , tree = { ... };

monkey.preOrder(tree, function (node, path, callback) {
  // do something async with the current node and/or path
  ...

  // signal that you are done
  callback();
});
```

### Pre-order traversal

Visits all nodes depth-first in async pre-order, meaning each parent node is visited before its child nodes and then all child nodes are visited asynchronously. This means all branches are visited in their own speed, so to say, and we can't know the order in which they will complete.

  preOrder(tree, nodeFunction, callback)

Arguments:

<dl>
  <dt><tt>tree</tt></dt>	<dd>the tree to traverse</dd>
  <dt><tt>nodeFunction</tt></dt>	<dd>the function called on each node. Receives the current node, the current path and a callback as arguments. Callback *must* be called eventually.</dd>
  <dt><tt>callback</tt></dt>	<dd>an optional callback, which is called after the whole tree has been traversed</dd>
</dl>

### Post-order traversal

Visits all nodes depth-first in async prost-order, meaning children will be visited before their parent node. Child nodes are visited asynchronously, meaning we can't know the order in which they will complete.

	preOrder(tree, nodeFunction, callback)

Take the same arguments as <tt>preOrder</tt>