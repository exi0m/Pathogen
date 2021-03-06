# Pathogen

<img src="https://www.creative-biolabs.com/vaccine/images/Pathogen-Target-Based-Vaccine-Design-Fig.2.jpg" alt="drawing" width="650" height="400"/>

## Technology Stack
- Language: Solidity
- IDE: Remix
- Testnet: MetaMask
- Developer environment: Ganache

## What is Pathogen?

<img src="https://i.ibb.co/NrmRn50/pathogen.jpg" >

Pathogen(PATH) is a token that adds liquidity to a set of consensus agreed tokens, to operate as a staking mechanism and reap the reward benefits that are accrued per transactions of the corresponding tokens of those pools.</p>

## Tokenomics
</p>
- The five tokens Pathogen is staking to is: Antigen(ANTI), Nitrotoken(NITRO), Soma(SOMA), Freshtoken(FRSH), and Viraltoken(VIRAL). 

- Initial supply circulation: </p>
  - 10,000,000 PATH tokens
  - 10,000,000 ANTI tokens
  - 10,000,000 NITRO tokens
  - 10,000,000 SOMA tokens
  - 10,000,000 FRSH tokens
  - 10,000,000 VIRAL tokens </p>

- Price of each token: $1.00</p>

- All based within the Ethereum network, each of these tokens have a TVL(Total Value Locked) fixed liquidity pool of $10,000,000. 

- Every transaction that takes place by all token owners of it's respective staked token gives a reward to the liquidity provider(PATH) of 0.02% per transaction, maxing at 1% total, which is rewarded after a 24 hour period.</p>

## Staking mechanism
 - Token owner has SOMA staked in the liquidity pool. All token holders of SOMA who execute transactions with SOMA will generate a 1% reward for the liquidity provider. </p>

- Pathogen is initially broken up into 20% per token to stake, based on how much the investor owns. </p>

- Suppose, if a user owns 100 tokens, it will utilize those 100 tokens and stake 20% into each liquidity pool. That 100 coins represents 0.01% of the circulating tokens. </p>
The Pathogen Trust has a $1,000,000 stake in each one of these liquidity pools, representing 10% of each pool, equaling a total of $5,000,000 PATH staked. 

- Since Pathogen does not represent the associated tokens' liquidity pools, based on how many tokens the user owns, is the exposure to the Pathogen Trust's stake in each pool. This will help on saving gas so no conversion between coins needs to take place(PATH <-> ANTI). </p>
 
- Consider this. A user owns 100 tokens, totaling $100 worth of PATH tokens. This means that $100 represents of one pool at 0.01% of a single pool(100/1000000), * 5(all the pools) represents 0.002% of the total staked. </p>

## Earning Rewards
- After a 24 hour period, those rewards remain within the liquidity pool but will also reward the user with additional PATH tokens as a form of elasticity, delegated based on amount of tokens owned. </p>

- Example: User owns 100 tokens. All 5 pools had 100 transactions. 100 transactions = 1% total of one liquidty pool. 100 transactions * 5 pools = 500 transactions total in one day. 1%(one pool's 100 transactions rewards for one day) * 5 pools = 10% accumulative total reward for one day. 

-  Each 1% will remain in the liquidity pools, but will represent as a reward to the token holder. 10% * the amount of current value of the user's ownership of the entire token supply(0.01%) = 0.01 tokens as a reward for being a token holder. The token holder after 24 hours will now have 100.01 tokens.

## Metrics defined/ calculated
**Legend: Execute functions as O: Owner/Contract Deployer; U: User/Non-Owner/Stakeholders**</p>
(Make sure environment is setup. Ganache/Truffle, Metamask, Remix, etc)</p>
1) Deploy Contract(O)
2) Transfer(0)(Stakeholders(s) address(es), token amount to transfer to stakeholder(s))
3) AddStakeholder(O)(Accepts and adds stakeholder to contract)
4) CreateStake(U)(Amount of tokens to stake by stakeholder)
5) totalStakes(O/U)(Checks how many coins are staked to contract)
6) calculateReward(O)(Generates rewards to distribute)
7) totalRewards(Calculates aggregated rewards)
8) distributeReward(O)(Distributes rewards to stakeholders)
9) withdrawReward(U)(Withdraws reward to stakeholder's wallet)
10) removeStake(U)(Amount of tokens you want to remove)
11) balanceOf(O/U)(Check balance of wallet)


## Conclusion
- The sentiment behind this token was to give the token holder the ability to part take in liquidity pool staking and reap the rewards without the numerous gas taxes that come along with the process. 
- With Ethereum's success and it's current Layer 1 structure, transaction fees will also rise as it will take a larger effort by the node validators. Layer 2 applications have arrived and Ethereum 2.0 hopes to bring a more cost efficient solution.

## Difficulties/Challenges Faced
- Importing/inheritence isnt as straight forward as other languages. 
- The inability to use float within code
- Remix isnt so forthcoming in errors. For instance, if you have the constructor ill-placed in the contract, the error counter shows, but no output

## Future Additions
- Add liquidity pool pairing with Ethereum or possibly other stable coins for staking
- Consensus voting forums to add/remove tokens to stake into
- Create a governance token, which can be given to stake holders based on the amount they hold, on voting proposals.

## Contributors
- Steven Mellor
- Amanullah Afzali
- Gabriel Valenzuela
- Satheesh Narasimman

## Presentation Link:
[Google Presentation](https://docs.google.com/presentation/d/1lA4LhZ7bd5inEWTjGGpatf_CegOAH8c5wGgmSHaqTAk/edit)

## References
- [Solidity Documentation](https://docs.soliditylang.org/en/v0.5.0/introduction-to-smart-contracts.html)
- [RemixIDE Documentation](https://remix-ide.readthedocs.io/en/latest/index.html)
- [Hackernoon - Implementing Staking in Solidity](https://medium.com/hackernoon/implementing-staking-in-solidity-1687302a82cf)
- [Trust Token's Github - Staking repo](https://github.com/trusttoken/TrustToken-smart-contracts/blob/master/staking.sol)
- [Tutorials Point - Solidity](https://www.tutorialspoint.com/solidity/index.htm)
