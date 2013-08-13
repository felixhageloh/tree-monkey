# Async tree traversal for nodejs #

<tt>tree-monkey</tt> takes a JSON or object literal tree of the form

```js
{
  "nodeA": {
    "nodeAA": {
      "nodeAAA": 'leaf'
    }
  },
  "nodeB": {
    "nodeBA": 42
    "nodeBB": []
  }
}
```

and traversers it asynchronously.

## Usage ##

The basic usage is as follows:

```js
var monkey = require('tree-monkey')
  , tree = { ... };

monkey.preOrder(tree, function (node, path, callback) {
  // do something async with the current node and/or path
  ...

  // signal that you are done
  callback();
});
```

### Pre-order traversal ###

Visits all nodes depth-first in async pre-order, meaning each parent node is visited before its child nodes and then all child nodes are visited asynchronously. This means all branches are visited in their own speed, so to say, and we can't know the order in which they will complete.


	preOrder(tree, nodeFunction, callback)


Arguments:

<dl>
  <dt>tree</dt>	<dd>the tree to traverse</dd>
  <dt>nodeFunction</dt>	<dd>the function called on each node. Receives the current node, the current path and a callback as arguments. Callback *must* be called eventually.</dd>
  <dt>callback</dt>	<dd>an optional callback, which is called after the whole tree has been traversed</dd>
</dl>

### Post-order traversal ###

Visits all nodes depth-first in async prost-order, meaning children will be visited before their parent node. Child nodes are visited asynchronously, meaning we can't know the order in which they will complete.


	preOrder(tree, nodeFunction, callback)


Take the same arguments as <tt>preOrder</tt>


# License #

(The MIT License)

Copyright (c) 2013 Felix Hageloh <felix.hageloh@gmail.com>

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the 'Software'), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.