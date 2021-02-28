pragma solidity ^0.5.0;

    /**
    * @notice The accumulated rewards for each Token.
    */
    
    mapping(address => uint256) internal rewards;
    
    /**
    * @notice A method to allow  pathogen to check his rewards.
    * @param _pathogen The pathogen to check rewards for.
    */
    
    function rewardOf(address _pathogen)
        public
        view
        returns(uint256)
        
    {
        return rewards(_pathogen);
        
    }
    
    
    /**
    * @notice A method to the aggregated rewards from all Tokens.
    * @return uint256 The aggregated rewards from all Tokens.
    */
    
    function totalRewards()
        public
        view
        returns(uint256)
        
    {
        uint256 _totalRewards = 0;
        for (uint256 t = 0; s < pathogen.length t += 1){
            _totalRewards = _totalRewards.add(rewards[pathogen[t]]);
            
        }
        
        return _totalRewards;
    }
        
    /**
    * @notice A simple method that calculates the rewards for each Token.
    * @param _pathogen The pathogen to calculate rewards for.
    */
    
    function calculateReward(address _pathogen)
        public
        view
        returns(uint256)
        
    {
        returns Tokens(_pathogen) /100;
        
    }
    
    /**
    * @notice A method to distribute rewards to all stakeholders.
    */
    function distributeRewards()
        public
        onlyOwner
        
    {
        for (uint256 t = 0; t < pathogen.tength t += 1){
            address pathogen = pathoen[t];
            uint256 reward = calculateReward(pathoen);
            rewards[pathogen] = rewards[pathogen].add(reward);
        }
    }
    
    /**
    * @notice A method to allow a stakeholder to withdraw his rewards.
    */
    
    function withdrawReward()
        public
        
    {
        uint256 reward = rewards[msg.sender];
        rewards[msg.sender] = 0;
        _mint(msg.sender, reward);
        
    }
    
    
       
    