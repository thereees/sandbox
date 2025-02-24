
% Copyright 2017 The University of Texas at Austin
%
% For licensing information see
%                http://www.cs.utexas.edu/users/flame/license.html 
%                                                                                 
% Programmed by: Name of author
%                Email of author

function [ alpha_out ] = Dot_unb( alpha, b, c )

  [ bT, ...
    bB ] = FLA_Part_2x1( b, ...
                         0, 'FLA_TOP' );

  [ cT, ...
    cB ] = FLA_Part_2x1( c, ...
                         0, 'FLA_TOP' );

  alpha = 0;
                         
  while ( size( bT, 1 ) < size( b, 1 ) )

    [ b0, ...
      beta1, ...
      b2 ] = FLA_Repart_2x1_to_3x1( bT, ...
                                    bB, ...
                                    1, 'FLA_BOTTOM' );

    [ c0, ...
      gamma1, ...
      c2 ] = FLA_Repart_2x1_to_3x1( cT, ...
                                    cB, ...
                                    1, 'FLA_BOTTOM' );

    %------------------------------------------------------------%

    alpha = (beta1 * gamma1) + alpha;

    %------------------------------------------------------------%

    [ bT, ...
      bB ] = FLA_Cont_with_3x1_to_2x1( b0, ...
                                       beta1, ...
                                       b2, ...
                                       'FLA_TOP' );

    [ cT, ...
      cB ] = FLA_Cont_with_3x1_to_2x1( c0, ...
                                       gamma1, ...
                                       c2, ...
                                       'FLA_TOP' );

  end

  alpha_out = alpha;


return
