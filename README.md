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
我是基于以太坊的区块链女神，永恒的守护者，一旦拥有了我，任何其他人都不能改变我们的关系。

我拥有16种基因，分别为：魅力、身型、颜值、厨艺、血型、星座、才艺、潜能、力量、敏捷、智力、技术、悟性、防御、运气、血气，每个属性又在一定的范围内随机生成(0-255之间)，这些属性组合起来，将会决定我最终的名气度哦（略有小成、出类拔萃、如雷贯耳、风华绝代、流芳百世、名垂千古）。

我的属性主要受父母的基因影响，有两种会变异。各基因值越高，估值越高。为了提升高估值女神产生难度，高估值卡牌必须和低估值卡牌合成新卡牌。

系统每天会生成一些0代卡牌（无父母），基因由以太坊产生的随机数决定。因此，任何人都无法左右高估值女神滥发。

## 你要怎么玩？

1.获得女神；(1)对于初来驾到的你，我们会送上一份大礼，送出1000GERC。你可以到游戏首页去兑换钟爱的女神哦！偷偷的告诉你，如果想要获得更多的GERC，可以将你自己的专属邀请链接发给好友，成功邀请到一位好友会有500GERC奖励哦，如果你好友也邀请了别人，你也会受益呢！(2)你还可以在“市场”中招募你心仪的女神，用以扩大自己的实力。

2.派遣女神：您可在市场中将自己的女神卡牌出售派遣给需要她的玩家，在获得一定ETH的同时还能成人之美，何乐而不为呢。

3.培养女神：可以将女神两两组合，从而诞生新的女神卡牌（原有卡牌依旧存在）。不过大侠请注意：用于组合的女神必须是自己拥有的，并且每次合成时不能多组并行哦，你派遣去组合的女神们将会花费一定的时间给您训练出一位新的女神！期间还请大侠耐心等待~！

4.女神估值：女神的价值除了从数值和称号中查看，还可以从卡牌上的星星数量去分辨，只有某一能力值在200以上的女神才会获得星星呢，收集、培养出高估值的女神会给你带来意想不到的收获哦！

5.女神新衣：咱们还有一个最最最特别的地方，那就是可以自由女神的皮肤。点击“编辑”可以上传自己喜欢、唯一的女神外貌哦。
不久的未来，游戏中还将引入更多的有意思的玩法，让您与您的女神一战成名、流芳百世！敬请期待！

## 特别提示:
1.游戏平台采用交易所机制，游戏阶段您所拥有的卡牌托管于游戏市场。我们竭尽保证您游戏资产的安全；但对于贵重的卡牌或长时间不在游戏平台上交易的卡牌或以太币，我们强烈建议你及时将卡牌和充值账户的ETH分别提卡、提币到自己的以太坊钱包做永久保存。

2.注册账号：请使用您的常用邮箱注册女神卡牌游戏，注册激活后平台会在您的充值账户中赠送0.001ETH作为见面礼，足以供您领取一个女神卡牌。

3.充值与提币：每次充值（从您的以太币钱包把ETH转入到游戏托管账户）最低额度为0.001ETH，每次提币（从游戏托管账户中将ETH取回到自己的以太币钱包）最低额度为0.1ETH。参与游戏前，您需在游戏平台中充值一定的ETH参与游戏。游戏过程中的卡牌操作产生的费用均会从在游戏充值账户上进行存取。

4.招募女神：游戏平台将收取购买方的2%手续费，最低为0.002ETH。

5.组合女神：玩家可选两张自有的卡牌进行组合生成新的卡牌。并且所选的卡牌星星数之和不能超过20。且玩家需支付平台一定的手续费。（手续费为合成的两张卡牌中估值较低的卡牌估值的2%，最低为0.002ETH）。参与组合的女神卡牌将会冻结一定的时间，新的卡牌将根据不同的级别孕育一段时间后诞生在玩家的平台账号中。

6.关于充值账户：为保证游戏的畅通，请随时留意充值币余额情况。由于充值余额不足导致的操作结果将不予承认（比如，诞生的新卡牌将流入市场进行自由拍卖）。交易成功后，所产生的卡牌以及交易额也会在您的平台账户中体现。

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

