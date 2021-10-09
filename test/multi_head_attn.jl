@testset "Multi-Head Attention Layer" begin
    nodes = 10  
    edges = 5
    in_dim = 16
    out_dim = 16 
    num_heads = 2 
    graph = SimpleGraph(nodes)
    add_edge!(graph, 1, 2)
    add_edge!(graph, 1, 3) 
    add_edge!(graph, 1, 4)
    add_edge!(graph, 2, 3) 
    add_edge!(graph, 3, 4)
    node_features = rand(in_dim, nodes)    # [feature_dim, num_nodes]
    edge_features = rand(out_dim, edges)   # [feature_dim, num_edges]
    graph = FeaturedGraph(graph, nf=node_features, ef=edge_features)

    layer = MultiHeadAttentionLayer(in_dim, out_dim ÷ num_heads, num_heads)
    node_feats, edge_feats = layer(graph)
    @test size(node_feats) == (out_dim, nodes) 
    @test size(edge_feats) == (out_dim, edges)
end
