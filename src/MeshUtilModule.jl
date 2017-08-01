"""
    MeshUtilModule

Module for mesh utility functions used in other meshing modules.
"""
module MeshUtilModule

using FinEtools.FTypesModule
import Base.IntSet

mutable struct HyperFaceContainer
    o::IntSet # numbers of the other nodes on the hyperface
    n::Int # new node number generated on the hyperface
end

makecontainer() = Dict{FInt, Array{HyperFaceContainer}}();

function addhyperface!(container,hyperface,newn)
    h=sort(vec(hyperface))
    anchor=h[1]; other=IntSet(h[2:end]);
    C=get(container,anchor,Array{HyperFaceContainer}(0));
    fnd=false;
    for k=1:length(C)
        if C[k].o == other
            fnd=true; break;
        end
    end
    if fnd!=true
        push!(C,HyperFaceContainer(other,newn)); newn=newn+1;#new node added
    end
    container[anchor]= C; # set the new array
    return newn           # return the number of the added node, possibly unchanged
end

function findhyperface!(container,hyperface)
    h=sort(vec(hyperface))
    anchor=h[1]; other=IntSet(h[2:end]);
    C=get(container,anchor,Array{HyperFaceContainer}(0));
    for k=1:length(C)
        if C[k].o == other
            return [anchor, C[k].o], C[k].n
        end
    end
    return [], 0
end

function ontosphere(xyz::FFltMat,radius::FFlt)
# % Project nodes onto a sphere of given radius.
# %
# % function fens= onto_sphere(fens,radius,list)
# %
# % fens = finite element node set,
# % radius = radius of the sphere,
# % list = optional argument, if not empty then only
# %	     the nodes in the list are to be moved; otherwise all nodes are moved.

    for j=1:size(xyz,1)
        xyz[j,:] =xyz[j,:]*radius/norm(xyz[j,:]);
    end
    return xyz;
end

# function inbox(box::FFltVec,sdim::FInt,x::FFltVec)
#     for i=1:sdim
#         if (!inrange(box[2*i-1],box[2*i],x[i]))
#             return false
#         end
#     end
#     return true
# end

end
