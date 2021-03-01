/* A stake_record mapping function is defined to record the stake size and the respective stakeholder */
/* The address of the stakeholder is mapped to their respective stake size */
mapping (address => uint256) public stake_record;

/* A function is defined that will return the amount of PATH staked by the respective stakeholder */
function amount_staked (address _pathogens) public view returns (uint256)
{
    return stake_record(_pathogens);
}

/* The function below aggregates the stakes from all the respective stakeholders 
The total count of stakes in the pathogen array is returned*/
function total_stake () public view returns (uint256)
{
    uint256 _aggregated_stakes= 0;
    /* position_number is the address' position in the pathogen array 
    if the position number is less than the pathogen array's length,
    increment the position_number*/
    for (uint position_number= 0; position_number < pathogen.length; position_number += 1)
    {
        _aggregated_stakes= _aggregated_stakes.add(stake_record[pathogen[position_number]]);
    }
    return _aggregated_stakes;
}

/* There needs to be a functionality to create and remove stakes 
In order to ensure a stakeholder does not rig/ manipulate the liquidity pool,
the necessary steps to prevent those are taken*/

/* A stake is created here */
function create_stake (uint256 _stake_size) public 
{
    /* if a stakeholder tries to stake more coins than they own,
    _burn will revert the stake creation */
    _burn (msg.sender, _stake_size);

    /* if the number of stakes of a particular stakeholder equals zero, 
    add the stakeholder to the 'pathogen' array*/
    if (stake_record[msg.sender]== 0) add_stakeholder(msg.sender);

    // increment the _stake_size in the stake_record
    stake_record[msg.sender]= stake_record[msg.sender].add(_stake_size);
}

/* A stake is purged if the stakeholder removes more token than they staked */
function remove_stake (uint256 _stake_size) public
{
    /* Decrement the _stake_size from stake_record*/
    stake_record[msg.sender]= stake_record[msg.sender].sub(_stake_size);
    
    /* remove the stakeholder */
    if (stake_record[msg.sender]== 0) remove_stakeholder(msg.sender);
    _mint (msg.sender, _stake_size);
}