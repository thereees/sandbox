function [ C_out ] = Gemm_unb_var3( A, B, C )
  [ AL, AR ] = FLA_Part_1x2( A, ...
                               0, 'FLA_LEFT' );
  [ BT, ...
    BB ] = FLA_Part_2x1( B, ...
                         0, 'FLA_TOP' );
  while ( size( AL, 2 ) < size( A, 2 ) )
    [ A0, a1, A2 ]= FLA_Repart_1x2_to_1x3( AL, AR, ...
                                         1, 'FLA_RIGHT' );
    [ B0, ...
      b1t, ...
      B2 ] = FLA_Repart_2x1_to_3x1( BT, ...
                                    BB, ...
                                    1, 'FLA_BOTTOM' );
    C = laff_ger( 1, a1, b1t, C);
    [ AL, AR ] = FLA_Cont_with_1x3_to_1x2( A0, a1, A2, ...
                                           'FLA_LEFT' );
    [ BT, ...
      BB ] = FLA_Cont_with_3x1_to_2x1( B0, ...
                                       b1t, ...
                                       B2, ...
                                       'FLA_TOP' );
  end
  C_out = C;
return
