﻿using Algorithms.UnionFind.Memory;
using System.Runtime.Serialization;
using System;

namespace Algorithms.UnionFind.UnionFind
{
    [Serializable]
    public class WeightedQuickUnionPathCompressionUF : IUnionFind, ISerializable
    {
        IRandomAccess<int> Id;
        IRandomAccess<int> Sizes;

        public int Size { get { return (int)Id.Size; } }

        public WeightedQuickUnionPathCompressionUF(IRandomAccess<int> id, IRandomAccess<int> sizes)
        {
            Id = id;
            Sizes = sizes;

            for (int i = 0; i < Id.Size; i++)
            {
                Id.Write(i, i);
                Sizes.Write(i, 1);
            }
        }

        private int root(int i)
        {
            while (i != Id.Read(i))
            {
                var grandparent = Id.Read(Id.Read(i));
                Id.Write(i, grandparent);

                i = Id.Read(i);
            }

            return i;
        }

        public bool IsConnected(int p, int q)
        {
            return root(p) == root(q);
        }

        public void Union(int p, int q)
        {
            int proot = root(p);
            int qroot = root(q);

            if (proot == qroot) return;

            if (Sizes.Read(proot) < Sizes.Read(qroot))
            {
                Id.Write(proot, qroot);
                Sizes.Write(qroot, Sizes.Read(qroot) + Sizes.Read(proot));
            }
            else
            {
                Id.Write(qroot, proot);
                Sizes.Write(proot, Sizes.Read(proot) + Sizes.Read(qroot));
            }
        }

        public WeightedQuickUnionPathCompressionUF(SerializationInfo info, StreamingContext ctxt)
        {
            Id = (MemoryReadWrite<int>)info.GetValue(nameof(Id), typeof(MemoryReadWrite<int>));
            Sizes = (MemoryReadWrite<int>)info.GetValue(nameof(Sizes), typeof(MemoryReadWrite<int>));
        }

        void ISerializable.GetObjectData(SerializationInfo info, StreamingContext context)
        {
            info.AddValue(nameof(Id), Id);
            info.AddValue(nameof(Sizes), Sizes);
        }
    }
}
