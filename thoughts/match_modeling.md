# Match Modeling

The `MATCH` part of a query can be modeled in a number of ways.

## Tree structure

```
{:bidi, edge, node, {:forward, edge, node, {:backward, edge, node, node}}}
```

**Issue:** It is not immediately clear if it is the LHS or RHS of an edge that is passed along to the parent.

## Node followed by sequence of edge-node extensions

```
[node, {:bidi, edge, node}, {:forward, edge, node}, {:backward, edge, node}]
```

## Sequence of elements

```
[node, {:bidi, edge}, node, {:forward, edge}, node, {:backward, edge}, node ]
```

I think that I like this one the most. But I want to incorporate the edge type (bidi, forward, backward) in the edge struct as well.
