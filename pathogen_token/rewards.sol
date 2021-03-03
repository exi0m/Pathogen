pragma solidity ^0.5.0;

    /*The accumulated rewards for each Token */
    
    /* A rewards mapping object is created */
    mapping(address => uint256) internal rewards;
    
    /* Define a function that will take an address and
    pass it to the rewards mapping object. Any stakeholder
    can check their rewards in this function */

    function check_rewards(address _pathogen)
        public
        view
        returns(uint256)      
    {
        return rewards(_pathogen);      
    }  

    /* Calcualte the aggregated rewards from all tokens
    and return the aggregated rewards */

    function total_rewards()
        public
        view
        returns(uint256)    
    {
        /* the reward for the pathogen token is 0.2 percent
        use path_reward as the variable to iterate over the pathogen array */

        uint256 _aggregated_reward = 0;
        for (uint256 path_reward = 0; path_reward < pathogen.length; path_reward += 0.2)
        {
            _aggregated_reward = _aggregated_reward.add(rewards[pathogen[path_reward]]);
            
        }     
        return _aggregated_reward;
    }
        
    /* calculate the rewards for each Token */
    
    function calculate_reward(address _pathogen)
        public
        view
        returns(uint256)  
    {
        return stake_record(_pathogen) /100;
        
    } 
    
    /* Distribute rewards to all Tokens 
    @steven: this is confusing. We iterate over the length of the pathogen array to add 
    all the stakeholders to whom the rewards need to be distributed. 
    
    How does 0.2 come in here? */
    function distribute_rewards() public only_owner       
    {
        for (uint256 path_reward= 0; path_reward < pathogen.length; path_reward += 0.2)
        {
            /* for all the addresses in the pathogen array, distribute a 0.2 percent reward */
            address rewarding_address = pathogen[path_reward];
            uint256 given_reward = calculate_reward(rewarding_address);

            /* all the addresses that receive the reward are added
            to the 'rewards' mapping object */
            rewards[rewarding_address] = rewards[rewarding_address].add(given_reward);
        }
    }
    
    /* function to withdraw stakeholder's rewards */  
    function withdraw_reward()
        public       
    {
        uint256 rewarding_address = rewards[msg.sender];
        rewards[msg.sender] = 0;
        _mint(msg.sender, rewarding_address);      
    }