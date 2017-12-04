"""
    NodalFieldModule

Module for nodal fields.
"""
module NodalFieldModule

using FinEtools.FTypesModule
import FinEtools.FieldModule: Field, nents
import FinEtools.FieldModule.@add_Field_fields

"""
    NodalField{T<:Number}

Nodal field.
"""
mutable struct NodalField{T<:Number} <: Field
    @add_Field_fields()
end

"""
    NodalField(data::FMat{T}=[]) where {T<:Number}

Constructor of nodal field.
"""
function NodalField(data::FMat{T}=[]) where {T<:Number}
    values = deepcopy(data)
    dofnums = 0*similar(values,FInt)
    is_fixed = similar(values,Bool)
    fill!(is_fixed, 0)
    fixed_values = zeros(T,size(values))
    nfreedofs = 0
    return NodalField(values, dofnums, is_fixed, fixed_values, nfreedofs)
end

"""
    nnodes(self::NodalField)::FInt = nents(self)

Provide the number of nodes  in the nodal field.
"""
nnodes(self::NodalField)::FInt = nents(self)

end
