(module
  (type (;0;) (func (param i32)))
  (type (;1;) (func (param i32 i32)))
  (type (;2;) (func (param i32) (result i32)))
  (type (;3;) (func (param i32 i32 i32)))
  (type (;4;) (func (param i32 i32) (result i32)))
  (type (;5;) (func))
  (type (;6;) (func (param i32 i32 i32 i32)))
  (type (;7;) (func (result i32)))
  (type (;8;) (func (param i32 i32 i32) (result i32)))
  (import "env" "abort" (func (;0;) (type 6)))
  (func (;1;) (type 1) (param i32 i32)
    (local i32 i32 i32 i32)
    get_local 1
    i32.load
    tee_local 3
    i32.const 1
    i32.and
    i32.eqz
    if  ;; label = @1
      i32.const 0
      i32.const 32
      i32.const 277
      i32.const 13
      call 0
      unreachable
    end
    get_local 3
    i32.const -4
    i32.and
    tee_local 2
    i32.const 16
    i32.ge_u
    if (result i32)  ;; label = @1
      get_local 2
      i32.const 1073741808
      i32.lt_u
    else
      i32.const 0
    end
    i32.eqz
    if  ;; label = @1
      i32.const 0
      i32.const 32
      i32.const 279
      i32.const 13
      call 0
      unreachable
    end
    get_local 2
    i32.const 256
    i32.lt_u
    if (result i32)  ;; label = @1
      get_local 2
      i32.const 4
      i32.shr_u
      set_local 2
      i32.const 0
    else
      get_local 2
      i32.const 31
      get_local 2
      i32.clz
      i32.sub
      tee_local 3
      i32.const 4
      i32.sub
      i32.shr_u
      i32.const 16
      i32.xor
      set_local 2
      get_local 3
      i32.const 7
      i32.sub
    end
    tee_local 3
    i32.const 23
    i32.lt_u
    if (result i32)  ;; label = @1
      get_local 2
      i32.const 16
      i32.lt_u
    else
      i32.const 0
    end
    i32.eqz
    if  ;; label = @1
      i32.const 0
      i32.const 32
      i32.const 292
      i32.const 13
      call 0
      unreachable
    end
    get_local 1
    i32.load offset=20
    set_local 4
    get_local 1
    i32.load offset=16
    tee_local 5
    if  ;; label = @1
      get_local 5
      get_local 4
      i32.store offset=20
    end
    get_local 4
    if  ;; label = @1
      get_local 4
      get_local 5
      i32.store offset=16
    end
    get_local 1
    get_local 0
    get_local 2
    get_local 3
    i32.const 4
    i32.shl
    i32.add
    i32.const 2
    i32.shl
    i32.add
    i32.load offset=96
    i32.eq
    if  ;; label = @1
      get_local 0
      get_local 2
      get_local 3
      i32.const 4
      i32.shl
      i32.add
      i32.const 2
      i32.shl
      i32.add
      get_local 4
      i32.store offset=96
      get_local 4
      i32.eqz
      if  ;; label = @2
        get_local 0
        get_local 3
        i32.const 2
        i32.shl
        i32.add
        get_local 0
        get_local 3
        i32.const 2
        i32.shl
        i32.add
        i32.load offset=4
        i32.const 1
        get_local 2
        i32.shl
        i32.const -1
        i32.xor
        i32.and
        tee_local 1
        i32.store offset=4
        get_local 1
        i32.eqz
        if  ;; label = @3
          get_local 0
          get_local 0
          i32.load
          i32.const 1
          get_local 3
          i32.shl
          i32.const -1
          i32.xor
          i32.and
          i32.store
        end
      end
    end)
  (func (;2;) (type 1) (param i32 i32)
    (local i32 i32 i32 i32 i32 i32)
    get_local 1
    i32.eqz
    if  ;; label = @1
      i32.const 0
      i32.const 32
      i32.const 205
      i32.const 13
      call 0
      unreachable
    end
    get_local 1
    i32.load
    tee_local 3
    i32.const 1
    i32.and
    i32.eqz
    if  ;; label = @1
      i32.const 0
      i32.const 32
      i32.const 207
      i32.const 13
      call 0
      unreachable
    end
    get_local 1
    i32.const 16
    i32.add
    get_local 1
    i32.load
    i32.const -4
    i32.and
    i32.add
    tee_local 4
    i32.load
    tee_local 5
    i32.const 1
    i32.and
    if  ;; label = @1
      get_local 3
      i32.const -4
      i32.and
      i32.const 16
      i32.add
      get_local 5
      i32.const -4
      i32.and
      i32.add
      tee_local 2
      i32.const 1073741808
      i32.lt_u
      if  ;; label = @2
        get_local 0
        get_local 4
        call 1
        get_local 1
        get_local 2
        get_local 3
        i32.const 3
        i32.and
        i32.or
        tee_local 3
        i32.store
        get_local 1
        i32.const 16
        i32.add
        get_local 1
        i32.load
        i32.const -4
        i32.and
        i32.add
        tee_local 4
        i32.load
        set_local 5
      end
    end
    get_local 3
    i32.const 2
    i32.and
    if  ;; label = @1
      get_local 1
      i32.const 4
      i32.sub
      i32.load
      tee_local 2
      i32.load
      tee_local 6
      i32.const 1
      i32.and
      i32.eqz
      if  ;; label = @2
        i32.const 0
        i32.const 32
        i32.const 228
        i32.const 15
        call 0
        unreachable
      end
      get_local 6
      i32.const -4
      i32.and
      i32.const 16
      i32.add
      get_local 3
      i32.const -4
      i32.and
      i32.add
      tee_local 7
      i32.const 1073741808
      i32.lt_u
      if  ;; label = @2
        block (result i32)  ;; label = @3
          get_local 0
          get_local 2
          call 1
          get_local 2
          get_local 7
          get_local 6
          i32.const 3
          i32.and
          i32.or
          tee_local 3
          i32.store
          get_local 2
        end
        set_local 1
      end
    end
    get_local 4
    get_local 5
    i32.const 2
    i32.or
    i32.store
    get_local 3
    i32.const -4
    i32.and
    tee_local 2
    i32.const 16
    i32.ge_u
    if (result i32)  ;; label = @1
      get_local 2
      i32.const 1073741808
      i32.lt_u
    else
      i32.const 0
    end
    i32.eqz
    if  ;; label = @1
      i32.const 0
      i32.const 32
      i32.const 243
      i32.const 13
      call 0
      unreachable
    end
    get_local 2
    get_local 1
    i32.const 16
    i32.add
    i32.add
    get_local 4
    i32.ne
    if  ;; label = @1
      i32.const 0
      i32.const 32
      i32.const 244
      i32.const 13
      call 0
      unreachable
    end
    get_local 4
    i32.const 4
    i32.sub
    get_local 1
    i32.store
    get_local 2
    i32.const 256
    i32.lt_u
    if (result i32)  ;; label = @1
      get_local 2
      i32.const 4
      i32.shr_u
      set_local 4
      i32.const 0
    else
      get_local 2
      i32.const 31
      get_local 2
      i32.clz
      i32.sub
      tee_local 2
      i32.const 4
      i32.sub
      i32.shr_u
      i32.const 16
      i32.xor
      set_local 4
      get_local 2
      i32.const 7
      i32.sub
    end
    tee_local 3
    i32.const 23
    i32.lt_u
    if (result i32)  ;; label = @1
      get_local 4
      i32.const 16
      i32.lt_u
    else
      i32.const 0
    end
    i32.eqz
    if  ;; label = @1
      i32.const 0
      i32.const 32
      i32.const 260
      i32.const 13
      call 0
      unreachable
    end
    get_local 0
    get_local 4
    get_local 3
    i32.const 4
    i32.shl
    i32.add
    i32.const 2
    i32.shl
    i32.add
    i32.load offset=96
    set_local 2
    get_local 1
    i32.const 0
    i32.store offset=16
    get_local 1
    get_local 2
    i32.store offset=20
    get_local 2
    if  ;; label = @1
      get_local 2
      get_local 1
      i32.store offset=16
    end
    get_local 0
    get_local 4
    get_local 3
    i32.const 4
    i32.shl
    i32.add
    i32.const 2
    i32.shl
    i32.add
    get_local 1
    i32.store offset=96
    get_local 0
    get_local 0
    i32.load
    i32.const 1
    get_local 3
    i32.shl
    i32.or
    i32.store
    get_local 0
    get_local 3
    i32.const 2
    i32.shl
    i32.add
    get_local 0
    get_local 3
    i32.const 2
    i32.shl
    i32.add
    i32.load offset=4
    i32.const 1
    get_local 4
    i32.shl
    i32.or
    i32.store offset=4)
  (func (;3;) (type 3) (param i32 i32 i32)
    (local i32 i32)
    get_local 2
    i32.const 15
    i32.and
    i32.eqz
    i32.const 0
    get_local 1
    i32.const 15
    i32.and
    i32.eqz
    i32.const 0
    get_local 1
    get_local 2
    i32.le_u
    select
    select
    i32.eqz
    if  ;; label = @1
      i32.const 0
      i32.const 32
      i32.const 386
      i32.const 4
      call 0
      unreachable
    end
    get_local 0
    i32.load offset=1568
    tee_local 3
    if  ;; label = @1
      get_local 1
      get_local 3
      i32.const 16
      i32.add
      i32.lt_u
      if  ;; label = @2
        i32.const 0
        i32.const 32
        i32.const 396
        i32.const 15
        call 0
        unreachable
      end
      get_local 3
      get_local 1
      i32.const 16
      i32.sub
      i32.eq
      if  ;; label = @2
        get_local 3
        i32.load
        set_local 4
        get_local 1
        i32.const 16
        i32.sub
        set_local 1
      end
    else
      get_local 1
      get_local 0
      i32.const 1572
      i32.add
      i32.lt_u
      if  ;; label = @2
        i32.const 0
        i32.const 32
        i32.const 408
        i32.const 4
        call 0
        unreachable
      end
    end
    get_local 2
    get_local 1
    i32.sub
    tee_local 2
    i32.const 48
    i32.lt_u
    if  ;; label = @1
      return
    end
    get_local 1
    get_local 4
    i32.const 2
    i32.and
    get_local 2
    i32.const 32
    i32.sub
    i32.const 1
    i32.or
    i32.or
    i32.store
    get_local 1
    i32.const 0
    i32.store offset=16
    get_local 1
    i32.const 0
    i32.store offset=20
    get_local 1
    get_local 2
    i32.add
    i32.const 16
    i32.sub
    tee_local 2
    i32.const 2
    i32.store
    get_local 0
    get_local 2
    i32.store offset=1568
    get_local 0
    get_local 1
    call 2)
  (func (;4;) (type 7) (result i32)
    (local i32 i32 i32)
    get_global 0
    tee_local 0
    i32.eqz
    if  ;; label = @1
      i32.const 1
      current_memory
      tee_local 0
      i32.gt_s
      if (result i32)  ;; label = @2
        i32.const 1
        get_local 0
        i32.sub
        grow_memory
        i32.const 0
        i32.lt_s
      else
        i32.const 0
      end
      if  ;; label = @2
        unreachable
      end
      i32.const 208
      tee_local 0
      i32.const 0
      i32.store
      i32.const 1776
      i32.const 0
      i32.store
      loop  ;; label = @2
        get_local 1
        i32.const 23
        i32.lt_u
        if  ;; label = @3
          get_local 1
          i32.const 2
          i32.shl
          i32.const 208
          i32.add
          i32.const 0
          i32.store offset=4
          i32.const 0
          set_local 2
          loop  ;; label = @4
            get_local 2
            i32.const 16
            i32.lt_u
            if  ;; label = @5
              get_local 1
              i32.const 4
              i32.shl
              get_local 2
              i32.add
              i32.const 2
              i32.shl
              i32.const 208
              i32.add
              i32.const 0
              i32.store offset=96
              get_local 2
              i32.const 1
              i32.add
              set_local 2
              br 1 (;@4;)
            end
          end
          get_local 1
          i32.const 1
          i32.add
          set_local 1
          br 1 (;@2;)
        end
      end
      i32.const 208
      i32.const 1792
      current_memory
      i32.const 16
      i32.shl
      call 3
      i32.const 208
      set_global 0
    end
    get_local 0)
  (func (;5;) (type 2) (param i32) (result i32)
    get_local 0
    i32.const 1073741808
    i32.ge_u
    if  ;; label = @1
      i32.const 80
      i32.const 32
      i32.const 457
      i32.const 29
      call 0
      unreachable
    end
    get_local 0
    i32.const 15
    i32.add
    i32.const -16
    i32.and
    tee_local 0
    i32.const 16
    get_local 0
    i32.const 16
    i32.gt_u
    select)
  (func (;6;) (type 4) (param i32 i32) (result i32)
    (local i32)
    get_local 1
    i32.const 256
    i32.lt_u
    if (result i32)  ;; label = @1
      get_local 1
      i32.const 4
      i32.shr_u
      set_local 1
      i32.const 0
    else
      get_local 1
      i32.const 536870904
      i32.lt_u
      if  ;; label = @2
        get_local 1
        i32.const 1
        i32.const 27
        get_local 1
        i32.clz
        i32.sub
        i32.shl
        i32.add
        i32.const 1
        i32.sub
        set_local 1
      end
      get_local 1
      i32.const 31
      get_local 1
      i32.clz
      i32.sub
      tee_local 2
      i32.const 4
      i32.sub
      i32.shr_u
      i32.const 16
      i32.xor
      set_local 1
      get_local 2
      i32.const 7
      i32.sub
    end
    tee_local 2
    i32.const 23
    i32.lt_u
    if (result i32)  ;; label = @1
      get_local 1
      i32.const 16
      i32.lt_u
    else
      i32.const 0
    end
    i32.eqz
    if  ;; label = @1
      i32.const 0
      i32.const 32
      i32.const 338
      i32.const 13
      call 0
      unreachable
    end
    get_local 0
    get_local 2
    i32.const 2
    i32.shl
    i32.add
    i32.load offset=4
    i32.const -1
    get_local 1
    i32.shl
    i32.and
    tee_local 1
    if (result i32)  ;; label = @1
      get_local 0
      get_local 1
      i32.ctz
      get_local 2
      i32.const 4
      i32.shl
      i32.add
      i32.const 2
      i32.shl
      i32.add
      i32.load offset=96
    else
      get_local 0
      i32.load
      i32.const -1
      get_local 2
      i32.const 1
      i32.add
      i32.shl
      i32.and
      tee_local 1
      if (result i32)  ;; label = @2
        get_local 0
        get_local 1
        i32.ctz
        tee_local 1
        i32.const 2
        i32.shl
        i32.add
        i32.load offset=4
        tee_local 2
        i32.eqz
        if  ;; label = @3
          i32.const 0
          i32.const 32
          i32.const 351
          i32.const 17
          call 0
          unreachable
        end
        get_local 0
        get_local 2
        i32.ctz
        get_local 1
        i32.const 4
        i32.shl
        i32.add
        i32.const 2
        i32.shl
        i32.add
        i32.load offset=96
      else
        i32.const 0
      end
    end)
  (func (;7;) (type 1) (param i32 i32)
    (local i32)
    current_memory
    tee_local 2
    get_local 1
    i32.const 536870904
    i32.lt_u
    if (result i32)  ;; label = @1
      get_local 1
      i32.const 1
      i32.const 27
      get_local 1
      i32.clz
      i32.sub
      i32.shl
      i32.const 1
      i32.sub
      i32.add
    else
      get_local 1
    end
    i32.const 16
    get_local 0
    i32.load offset=1568
    get_local 2
    i32.const 16
    i32.shl
    i32.const 16
    i32.sub
    i32.ne
    i32.shl
    i32.add
    i32.const 65535
    i32.add
    i32.const -65536
    i32.and
    i32.const 16
    i32.shr_u
    tee_local 1
    get_local 2
    get_local 1
    i32.gt_s
    select
    grow_memory
    i32.const 0
    i32.lt_s
    if  ;; label = @1
      get_local 1
      grow_memory
      i32.const 0
      i32.lt_s
      if  ;; label = @2
        unreachable
      end
    end
    get_local 0
    get_local 2
    i32.const 16
    i32.shl
    current_memory
    i32.const 16
    i32.shl
    call 3)
  (func (;8;) (type 3) (param i32 i32 i32)
    (local i32 i32)
    get_local 1
    i32.load
    set_local 3
    get_local 2
    i32.const 15
    i32.and
    if  ;; label = @1
      i32.const 0
      i32.const 32
      i32.const 365
      i32.const 13
      call 0
      unreachable
    end
    get_local 3
    i32.const -4
    i32.and
    get_local 2
    i32.sub
    tee_local 4
    i32.const 32
    i32.ge_u
    if  ;; label = @1
      get_local 1
      get_local 2
      get_local 3
      i32.const 2
      i32.and
      i32.or
      i32.store
      get_local 2
      get_local 1
      i32.const 16
      i32.add
      i32.add
      tee_local 1
      get_local 4
      i32.const 16
      i32.sub
      i32.const 1
      i32.or
      i32.store
      get_local 0
      get_local 1
      call 2
    else
      get_local 1
      get_local 3
      i32.const -2
      i32.and
      i32.store
      get_local 1
      i32.const 16
      i32.add
      get_local 1
      i32.load
      i32.const -4
      i32.and
      i32.add
      get_local 1
      i32.const 16
      i32.add
      get_local 1
      i32.load
      i32.const -4
      i32.and
      i32.add
      i32.load
      i32.const -3
      i32.and
      i32.store
    end)
  (func (;9;) (type 8) (param i32 i32 i32) (result i32)
    (local i32 i32)
    get_global 1
    if  ;; label = @1
      i32.const 0
      i32.const 32
      i32.const 490
      i32.const 13
      call 0
      unreachable
    end
    get_local 0
    get_local 1
    call 5
    tee_local 4
    call 6
    tee_local 3
    i32.eqz
    if  ;; label = @1
      i32.const 1
      set_global 1
      i32.const 0
      set_global 1
      get_local 0
      get_local 4
      call 6
      tee_local 3
      i32.eqz
      if  ;; label = @2
        get_local 0
        get_local 4
        call 7
        get_local 0
        get_local 4
        call 6
        tee_local 3
        i32.eqz
        if  ;; label = @3
          i32.const 0
          i32.const 32
          i32.const 502
          i32.const 19
          call 0
          unreachable
        end
      end
    end
    get_local 3
    i32.load
    i32.const -4
    i32.and
    get_local 4
    i32.lt_u
    if  ;; label = @1
      i32.const 0
      i32.const 32
      i32.const 510
      i32.const 13
      call 0
      unreachable
    end
    get_local 3
    i32.const 0
    i32.store offset=4
    get_local 3
    get_local 2
    i32.store offset=8
    get_local 3
    get_local 1
    i32.store offset=12
    get_local 0
    get_local 3
    call 1
    get_local 0
    get_local 3
    get_local 4
    call 8
    get_local 3)
  (func (;10;) (type 4) (param i32 i32) (result i32)
    call 4
    get_local 0
    get_local 1
    call 9
    i32.const 16
    i32.add)
  (func (;11;) (type 0) (param i32)
    (local i32)
    get_local 0
    i32.load offset=4
    tee_local 1
    i32.const -268435456
    i32.and
    get_local 1
    i32.const 1
    i32.add
    i32.const -268435456
    i32.and
    i32.ne
    if  ;; label = @1
      i32.const 0
      i32.const 144
      i32.const 109
      i32.const 2
      call 0
      unreachable
    end
    get_local 0
    get_local 1
    i32.const 1
    i32.add
    i32.store offset=4
    get_local 0
    i32.load
    i32.const 1
    i32.and
    if  ;; label = @1
      i32.const 0
      i32.const 144
      i32.const 112
      i32.const 13
      call 0
      unreachable
    end)
  (func (;12;) (type 2) (param i32) (result i32)
    get_local 0
    i32.const 204
    i32.gt_u
    if  ;; label = @1
      get_local 0
      i32.const 16
      i32.sub
      call 11
    end
    get_local 0)
  (func (;13;) (type 0) (param i32)
    get_local 0
    i32.const 204
    i32.gt_u
    if  ;; label = @1
      get_local 0
      i32.const 16
      i32.sub
      call 16
    end)
  (func (;14;) (type 2) (param i32) (result i32)
    (local i32 i32 i32 i32)
    i32.const 1
    set_local 1
    loop  ;; label = @1
      get_local 2
      get_local 0
      i32.lt_s
      if  ;; label = @2
        get_local 1
        get_local 3
        i32.add
        set_local 4
        get_local 1
        set_local 3
        get_local 4
        set_local 1
        get_local 2
        i32.const 1
        i32.add
        set_local 2
        br 1 (;@1;)
      end
    end
    get_local 1)
  (func (;15;) (type 5)
    nop)
  (func (;16;) (type 0) (param i32)
    (local i32 i32)
    get_local 0
    i32.load offset=4
    tee_local 2
    i32.const 268435455
    i32.and
    set_local 1
    get_local 0
    i32.load
    i32.const 1
    i32.and
    if  ;; label = @1
      i32.const 0
      i32.const 144
      i32.const 122
      i32.const 13
      call 0
      unreachable
    end
    get_local 1
    i32.const 1
    i32.eq
    if  ;; label = @1
      get_local 0
      i32.const 16
      i32.add
      call 17
      get_local 2
      i32.const -2147483648
      i32.and
      if  ;; label = @2
        i32.const 0
        i32.const 144
        i32.const 126
        i32.const 17
        call 0
        unreachable
      end
      get_local 0
      get_local 0
      i32.load
      i32.const 1
      i32.or
      i32.store
      get_global 0
      get_local 0
      call 2
    else
      get_local 1
      i32.const 0
      i32.le_u
      if  ;; label = @2
        i32.const 0
        i32.const 144
        i32.const 136
        i32.const 15
        call 0
        unreachable
      end
      get_local 0
      get_local 1
      i32.const 1
      i32.sub
      get_local 2
      i32.const -268435456
      i32.and
      i32.or
      i32.store offset=4
    end)
  (func (;17;) (type 0) (param i32)
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          get_local 0
          i32.const 8
          i32.sub
          i32.load
          br_table 0 (;@3;) 0 (;@3;) 1 (;@2;) 2 (;@1;)
        end
        return
      end
      get_local 0
      i32.load
      tee_local 0
      if  ;; label = @2
        get_local 0
        i32.const 204
        i32.ge_u
        if  ;; label = @3
          get_local 0
          i32.const 16
          i32.sub
          call 16
        end
      end
      return
    end
    unreachable)
  (memory (;0;) 1)
  (global (;0;) (mut i32) (i32.const 0))
  (global (;1;) (mut i32) (i32.const 0))
  (global (;2;) i32 (i32.const 176))
  (export "memory" (memory 0))
  (export "__alloc" (func 10))
  (export "__retain" (func 12))
  (export "__release" (func 13))
  (export "__collect" (func 15))
  (export "__rtti_base" (global 2))
  (export "fib" (func 14))
  (data (i32.const 16) "\1e\00\00\00\01\00\00\00\01\00\00\00\1e\00\00\00~\00l\00i\00b\00/\00r\00t\00/\00t\00l\00s\00f\00.\00t\00s")
  (data (i32.const 64) "(\00\00\00\01\00\00\00\01\00\00\00(\00\00\00a\00l\00l\00o\00c\00a\00t\00i\00o\00n\00 \00t\00o\00o\00 \00l\00a\00r\00g\00e")
  (data (i32.const 128) "\1e\00\00\00\01\00\00\00\01\00\00\00\1e\00\00\00~\00l\00i\00b\00/\00r\00t\00/\00p\00u\00r\00e\00.\00t\00s")
  (data (i32.const 176) "\03\00\00\00\10\00\00\00\00\00\00\00\10\00\00\00\00\00\00\00\10"))
