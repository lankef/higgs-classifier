C     Diagram 1
      DATA MAPCONFIG(1)/1/
      DATA (IFOREST(I,-1,1),I=1,2)/5,4/
      DATA (SPROP(I,-1,1),I=1,1)/21/
      DATA TPRID(-1,1)/0/
      DATA (IFOREST(I,-2,1),I=1,2)/-1,3/
      DATA (SPROP(I,-2,1),I=1,1)/21/
      DATA TPRID(-2,1)/0/
C     Diagram 2
      DATA MAPCONFIG(2)/2/
      DATA (IFOREST(I,-1,2),I=1,2)/1,4/
      DATA TPRID(-1,2)/2/
      DATA (SPROP(I,-1,2),I=1,1)/0/
      DATA (IFOREST(I,-2,2),I=1,2)/-1,5/
      DATA TPRID(-2,2)/21/
      DATA (SPROP(I,-2,2),I=1,1)/0/
      DATA (IFOREST(I,-3,2),I=1,2)/-2,3/
C     Diagram 3
      DATA MAPCONFIG(3)/3/
      DATA (IFOREST(I,-1,3),I=1,2)/1,5/
      DATA TPRID(-1,3)/2/
      DATA (SPROP(I,-1,3),I=1,1)/0/
      DATA (IFOREST(I,-2,3),I=1,2)/-1,4/
      DATA TPRID(-2,3)/21/
      DATA (SPROP(I,-2,3),I=1,1)/0/
      DATA (IFOREST(I,-3,3),I=1,2)/-2,3/
C     Diagram 4
      DATA MAPCONFIG(4)/4/
      DATA (IFOREST(I,-1,4),I=1,2)/1,3/
      DATA TPRID(-1,4)/21/
      DATA (SPROP(I,-1,4),I=1,1)/0/
      DATA (IFOREST(I,-2,4),I=1,2)/-1,5/
      DATA TPRID(-2,4)/2/
      DATA (SPROP(I,-2,4),I=1,1)/0/
      DATA (IFOREST(I,-3,4),I=1,2)/-2,4/
C     Diagram 5
      DATA MAPCONFIG(5)/5/
      DATA (IFOREST(I,-1,5),I=1,2)/1,3/
      DATA TPRID(-1,5)/21/
      DATA (SPROP(I,-1,5),I=1,1)/0/
      DATA (IFOREST(I,-2,5),I=1,2)/-1,4/
      DATA TPRID(-2,5)/2/
      DATA (SPROP(I,-2,5),I=1,1)/0/
      DATA (IFOREST(I,-3,5),I=1,2)/-2,5/
C     Diagram 6
      DATA MAPCONFIG(6)/6/
      DATA (IFOREST(I,-1,6),I=1,2)/5,4/
      DATA (SPROP(I,-1,6),I=1,1)/21/
      DATA TPRID(-1,6)/0/
      DATA (IFOREST(I,-2,6),I=1,2)/1,3/
      DATA TPRID(-2,6)/21/
      DATA (SPROP(I,-2,6),I=1,1)/0/
      DATA (IFOREST(I,-3,6),I=1,2)/-2,-1/
C     Diagram 7
      DATA MAPCONFIG(7)/7/
      DATA (IFOREST(I,-1,7),I=1,2)/5,4/
      DATA (SPROP(I,-1,7),I=1,1)/21/
      DATA TPRID(-1,7)/0/
      DATA (IFOREST(I,-2,7),I=1,2)/1,-1/
      DATA TPRID(-2,7)/21/
      DATA (SPROP(I,-2,7),I=1,1)/0/
      DATA (IFOREST(I,-3,7),I=1,2)/-2,3/
C     Number of configs
      DATA MAPCONFIG(0)/7/