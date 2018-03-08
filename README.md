# CryptoGoddessCards
A new cards game built on Ethereum. Each card is marked with a Chinese ancient goddess or female warriors. Different goddess is born(created) with different characters controlled by 16 gene pieces.  Player can obtain, exchange or sale the card in the game. 
# About sources
All smart contracts are wrote in Solidity and publish in Ethereum. Files are organized as following:
## CardBase.sol
Base contract for Crypto Goddess Cards. Holds all common structs, events and base variables.
## CardCore.sol
Crypto Goddess Cards: Collectible, combinable and competive on the Ethereum blockchain.
## CardMinting.sol
All functions related to creating goddess cards.
## CardOwnership.sol
The facet of the Crypto Goddess Cards core contract that manages ownership, ERC-721 (draft) compliant.
## CardAccessControl.sol
A facet of CardCore that manages special access privileges.
## ERC721Draft.sol
Interface for contracts conforming to ERC-721: Non-Fungible Tokens. This file is come from Dieter Shirley <dete@axiomzen.co> (https://github.com/dete)

-------------------------------------------------------

# 女神养成记（区块链卡牌游戏）
这是一款基于以太坊的全新的卡牌类游戏。该游戏每张卡片都标有中国古代女神或女勇士，这些女神由16个基因片段演绎出不同的女神特性。玩家可以在游戏中获得、交换或销售卡牌。
以下是游戏介绍。

## 我是谁?
Hi~~我是区块链赋能的女神。女神们每位都有独一无二的属性和能力的哦。一旦你拥有了我，我们的关系将被永远记录在区块链上，任何人都不能改变。
我有16个属性特征，分别为：魅力、身型、颜值、厨艺、血型、星座、才艺、潜能、力量、敏捷、智力、技术、悟性、防御、运气、血气。每个属性的属性值在0-255之间随机生成，然而属性又按数值大小划分为5个等级，由小到大分别为： B级（0-51）、A（52-102）级、S级（103-153）、SS级（154-204）、SSS级（205-255）。这些属性组合起来，将会决定我最终的名气度哦（无名小辈、略有小成、赫赫有名、风华绝代、名扬天下、举世无双、名垂千古、震古烁今）。
你要怎么玩儿？
1.	招募女神：你可以在女神营中招募到你心仪的女神卡牌，用以扩大自己的实力。
2.	派遣女神：您可在市场中将自己的女神卡牌出售派遣给需要她的玩家，成人之美。
3.	组合女神：如果您拥有多种女神卡牌，可以两两组合诞生新的女神卡牌（原有卡牌依旧存在）。不过大侠请注意：用于组合的女神必须是自己拥有的，并且每次合成时不能多组并行哦，你派遣去组合的女神们将会花费一定的时间给您训练出一位新的女神！期间还请大侠耐心等待~！

## 名气度称号划分说明
1.	无名小辈：所有属性为B级 
2.	略有小成：拥有A级属性
3.	赫赫有名：所有属性到达A级
4.	风华绝代：有S级属性，且最低属性等级为：A级
5.	名扬天下：所有属性均为S级
6.	举世无双：有SS级属性，且最低属性等级为：S级
7.	名垂千古：所有属性均为SS级
8.	震古烁今：拥有SSS级属性，最低属性等级为：S级 
不久的未来，游戏中还将引入更多的有意思的玩法，让您与您的女神一战成名、流芳百世！敬请期待！

## 特别提示:
1.	游戏平台采用交易所机制，游戏阶段您所拥有的卡牌托管于游戏市场。我们竭尽保证您游戏资产的安全；但对于贵重的卡牌或长时间不在游戏平台上交易的卡牌或以太币，我们强烈建议你及时将卡牌和充值账户的ETH分别提卡、提币到自己的以太坊钱包做永久保存。
2.	注册账号：请使用您的常用邮箱注册女神卡牌游戏，注册激活后平台会在您的充值账户中赠送0.001ETH作为见面礼，足以供您领取一个女神卡牌。
3.	充值与提币：每次充值（从您的以太币钱包把ETH转入到游戏托管账户）最低额度为0.001ETH，每次提币（从游戏托管账户中将ETH取回到自己的以太币钱包）最低额度为0.1ETH。参与游戏前，您需在游戏平台中充值一定的ETH参与游戏。游戏过程中的卡牌操作产生的费用均会从在游戏充值账户上进行存取。
4.	招募女神：游戏平台将依据女神卡牌的稀有度在充值账户中收取相应的费用，具体详见市场报价，同时另收0.002ETH平台手续费。
5.	赠与女神：仅收取0.002ETH平台手续费。
6.	派遣女神：通过在市场上销售女神卡牌实现女神的派遣。销售价由玩家可结合同等级的卡牌的市场均价自行定义。为平抑投机，平台将统一收取售价与平台定价差价的10%作为增值税并外加0.002ETH平台手续费。
7.	组合女神：玩家可将两张自有的卡牌进行组合生成新的卡牌。新的卡牌的生成将收取同级别女神卡牌平台定价的10%的增值税并额外收取0.002ETH的手续费。参与组合的女神卡牌将会冻结一定的时间，新的卡牌将根据不同的级别孕育一段时间后诞生在玩家的平台账号中。
8.	手续费与增值税：平台征收0.002ETH手续费用于平台维护、新卡牌与游戏内容的持续研发以及平台的升级；增值税用于抑制过于高频的投机行为，营造良好的游戏氛围。根据税收情况，平台将不定期针对游戏做出贡献的玩家投放游戏福利以资奖励。手续费、增值税的征收对象为交易后的持币方。比如，玩家A将卡牌（平台定价0.02ETH）以0.5ETH售价卖给玩家B，那么玩家B支付0.5ETH，玩家A实际收益为：0.5-(0.5-0.02)×10%-0.002=0.45ETH；再比如，玩家C将两张卡牌合成新卡牌（平台定价0.04ETH），那么在合成完成前玩家C需确保充值账户上拥有0.04×10%+0.002ETH=0.006ETH的余额（否则合成的新卡牌将被市场自由拍卖）。
9.	关于充值账户：为保证游戏的畅通，请随时留意充值币余额情况。由于充值余额不足导致的操作结果将不予承认（比如，诞生的新卡牌将流入市场进行自由拍卖）。交易成功后，所产生的卡牌以及交易额也会在您的平台账户中体现。

# 有关代码
所有的智能合约代码均使用Solidity语言编制，文件由以下几个构成：
## CardBase.sol
加密女神卡牌的合约。定义所有数据结构、事件和基本变量。
## CardCore.sol
加密女神卡牌核心合约，是卡牌所有功能全集的封装形态，定义卡牌如何获取、组合和销售卡牌。
## CardMinting.sol
卡牌生成合约，定义了初代卡牌的生成原则以及后代卡牌的合成规则。
## CardOwnership.sol
卡牌的拥有权限合约，定义了卡牌与拥有者之间的相关关系的定义与查询功能。
## CardAccessControl.sol
卡牌访问合约，针对卡牌游戏中不同功能接口调用的权限定义。
## ERC721Draft.sol
ERC721通证接口合约。该合约引用至Dieter Shirley <dete@axiomzen.co> ，具体详见https://github.com/dete。

