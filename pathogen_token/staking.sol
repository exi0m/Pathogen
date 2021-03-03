    /**
    * @notice The stake_record for each stakeholder.
    */
   mapping(address => uint256) internal stake_record;
   

    /**
    * @notice A method for a stakeholder to create a stake.
    * @param _stake_size The size of the stake to be created.
    */
   function createStake(uint256 _stake_size)
       public
   {
       _burn(msg.sender, _stake_size);
       if(stake_record[msg.sender] == 0) addStakeholder(msg.sender);
       stake_record[msg.sender] = stake_record[msg.sender].add(_stake_size);
   }

   /**
    * @notice A method for a stakeholder to remove a stake.
    * @param _stake_size The size of the stake to be removed.
    */
   function removeStake(uint256 _stake_size)
       public
   {
       stake_record[msg.sender] = stake_record[msg.sender].sub(_stake_size);
       if(stake_record[msg.sender] == 0) removeStakeholder(msg.sender);
       _mint(msg.sender, _stake_size);
   }