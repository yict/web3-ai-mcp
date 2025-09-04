# 一元夺宝游戏 (One Dollar Treasure)

这是一个基于区块链的一元夺宝游戏智能合约项目，使用 Solidity 语言开发，基于 Foundry 框架构建。

## 游戏规则

1. 每个用户可以投入 1 USDT 参与游戏
2. 当达到设定的开奖周期后，系统会进行开奖
3. 开奖时随机选择一名幸运用户，获得资金池 98% 的 USDT
4. 剩余 2% 的 USDT 转入项目方的国库合约，作为平台运营手续费

## 合约功能

- `participate()`: 用户参与游戏，需要预先授权合约转移 1 USDT
- `draw()`: 开奖函数，只有在开奖周期结束后才能调用
- `setTreasury()`: 设置国库地址（仅管理员）
- `setLotteryPeriod()`: 设置开奖周期（仅管理员）
- `emergencyWithdraw()`: 紧急提款功能（仅管理员）

## 技术特点

1. 使用区块哈希和时间戳生成伪随机数选择获胜者
2. 支持设置开奖周期，周期结束后才能开奖
3. 具有管理员权限控制关键参数的修改
4. 包含紧急提款功能以应对异常情况

## 部署说明

1. 确保你已经安装了 Foundry 开发工具
2. 设置环境变量：
   - `PRIVATE_KEY`: 部署者的私钥
   - `USDT_ADDRESS`: USDT 代币合约地址
   - `TREASURY_ADDRESS`: 项目方国库地址
   - `LOTTERY_PERIOD`: 开奖周期（区块数）
3. 运行部署命令：
   ```bash
   forge script script/Treasure.s.sol:TreasureScript --rpc-url <your_rpc_url> --broadcast
   ```

## 测试

运行测试套件：

```bash
forge test
```

## 安全注意事项

1. 当前实现使用区块信息生成伪随机数，这在一定程度上可能受到矿工操纵的影响
2. 生产环境中建议使用 Chainlink VRF 等更安全的随机数源
3. 合约已包含基本的权限控制和输入验证