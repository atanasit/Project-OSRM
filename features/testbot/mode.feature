@routing @testbot @mode @todo
Feature: Testbot - Mode flag

# testbot modes:
# 1 normal
# 2 route
# 3 river downstream
# 4 river upstream

	Background:
		Given the profile "testbot"
    
	Scenario: Testbot - Mode for routes
		Given the node map
		 | a | b |   |   |   |
		 |   | c | d | e | f |

		And the ways
		 | nodes | highway | route | duration |
		 | ab    | primary |       |          |
		 | bc    |         | ferry | 0:01     |
		 | cd    | primary |       |          |
		 | de    | primary |       |          |
		 | ef    | primary |       |          |

		When I route I should get
		 | from | to | route          | turns                                         | modes     |
		 | a    | d  | ab,bc,cd       | head,right,left,destination                   | 1,2,1     |
		 | d    | a  | cd,bc,ab       | head,right,left,destination                   | 1,2,1     |
		 | c    | a  | bc,ab          | head,left,destination                         | 2,1       |
		 | d    | b  | cd,bc          | head,right,destination                        | 1,2       |
		 | a    | c  | ab,bc          | head,right,destination                        | 1,2       |
		 | b    | d  | bc,cd          | head,left,destination                         | 2,1       |
		 | a    | f  | ab,bc,cd,de,ef | head,right,left,straight,straight,destination | 1,2,1,1,1 |

    @x1
    Scenario: Testbot - Modes for each direction
    	Given the node map
    	 |   |   |   |   |   |   | d |
    	 |   |   |   |   |   | 2 |   |
    	 |   |   |   |   | 6 |   | 5 |
    	 | a | 0 | b | c |   |   |   |
    	 |   |   |   |   | 4 |   | 1 |
    	 |   |   |   |   |   | 3 |   |
    	 |   |   |   |   |   |   | e |

    	And the ways
    	 | nodes | highway | oneway |
    	 | abc   | primary |        |
    	 | cd    | primary | yes    |
    	 | ce    | river   |        |
    	 | de    | primary |        |

    	When I route I should get
    	 | from | to | route        | modes   |
    	 | 0    | 1  | abc,ce,de    | 1,3,1   |
    	 | 1    | 0  | de,ce,abc    | 1,4,1   |
    	 | 0    | 2  | abc,cd       | 1,1     |
    	 | 2    | 0  | cd,de,ce,abc | 1,1,4,1 |
    	 | 0    | 3  | abc,ce       | 1,3     |
    	 | 3    | 0  | ce,abc       | 4,1     |
    	 | 4    | 3  | ce           | 3       |
    	 | 3    | 4  | ce           | 4       |
    	 | 3    | 1  | ce,de        | 3,1     |
    	 | 1    | 3  | de,ce        | 1,4     |
    	 | a    | e  | abc,ce       | 1,3     |
    	 | e    | a  | ce,abc       | 4,1     |
    	 | a    | d  | abc,cd       | 1,1     |
    	 | d    | a  | de,ce,abc    | 1,4,1   |
    
     @x2
     Scenario: Testbot - Modes in each direction (simple)
     	Given the node map
    	 |   | 0 | 1 |   |
    	 | a |   |   | b |

     	And the ways
     	 | nodes | highway | oneway |
     	 | ab    | river   |        |

     	When I route I should get
     	 | from | to | route | modes |
     	 | 0    | 1  | ab    | 3     |
     	 | 1    | 0  | ab    | 4     |
