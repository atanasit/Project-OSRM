@routing @bicycle @mode @todo
Feature: Bike - Mode flag

# bicycle modes:
# 1 bike
# 2 ferry
# 3 push

	Background:
		Given the profile "bicycle"
    
    Scenario: Bike - Mode when using a ferry
    	Given the node map
    	 | a | b |   |
    	 |   | c | d |

    	And the ways
    	 | nodes | highway | route | duration |
    	 | ab    | primary |       |          |
    	 | bc    |         | ferry | 0:01     |
    	 | cd    | primary |       |          |

    	When I route I should get
    	 | from | to | route    | turns                       | modes |
    	 | a    | d  | ab,bc,cd | head,right,left,destination | 1,2,1 |
    	 | d    | a  | cd,bc,ab | head,right,left,destination | 1,2,1 |
    	 | c    | a  | bc,ab    | head,left,destination       | 2,1   |
    	 | d    | b  | cd,bc    | head,right,destination      | 1,2   |
    	 | a    | c  | ab,bc    | head,right,destination      | 1,2   |
    	 | b    | d  | bc,cd    | head,left,destination       | 2,1   |

     Scenario: Bike - Mode when pushing bike against oneways
     	Given the node map
     	 | a | b |   |
     	 |   | c | d |

     	And the ways
     	 | nodes | highway | oneway |
     	 | ab    | primary |        |
     	 | bc    | primary | yes    |
     	 | cd    | primary |        |

     	When I route I should get
     	 | from | to | route    | turns                       | modes |
     	 | a    | d  | ab,bc,cd | head,right,left,destination | 1,1,1 |
     	 | d    | a  | cd,bc,ab | head,right,left,destination | 1,3,1 |
     	 | c    | a  | bc,ab    | head,left,destination       | 3,1   |
     	 | d    | b  | cd,bc    | head,right,destination      | 1,3   |
     	 | a    | c  | ab,bc    | head,right,destination      | 1,1   |
     	 | b    | d  | bc,cd    | head,left,destination       | 1,1   |

     Scenario: Bike - Mode when pushing on pedestrain streets
     	Given the node map
     	 | a | b |   |
     	 |   | c | d |

     	And the ways
     	 | nodes | highway    |
     	 | ab    | primary    |
     	 | bc    | pedestrian |
     	 | cd    | primary    |

     	When I route I should get
     	 | from | to | route    | turns                       | modes |
     	 | a    | d  | ab,bc,cd | head,right,left,destination | 1,3,1 |
     	 | d    | a  | cd,bc,ab | head,right,left,destination | 1,3,1 |
     	 | c    | a  | bc,ab    | head,left,destination       | 3,1   |
     	 | d    | b  | cd,bc    | head,right,destination      | 1,3   |
     	 | a    | c  | ab,bc    | head,right,destination      | 1,3   |
     	 | b    | d  | bc,cd    | head,left,destination       | 3,1   |

     Scenario: Bike - Mode when pushing on pedestrain areas
     	Given the node map
     	 | a | b |   |   |
     	 |   | c | d | f |

     	And the ways
     	 | nodes | highway    | area |
     	 | ab    | primary    |      |
     	 | bcd   | pedestrian | yes  |
     	 | df    | primary    |      |

     	When I route I should get
     	 | from | to | route     | modes |
     	 | a    | f  | ab,bcd,df | 1,3,1 |
     	 | f    | a  | df,bcd,ab | 1,3,1 |
     	 | d    | a  | bcd,ab    | 3,1   |
     	 | f    | b  | df,bcd    | 1,3   |
     	 | a    | d  | ab,bcd    | 1,3   |
     	 | b    | f  | bcd,df    | 3,1   |
