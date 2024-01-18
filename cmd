
dotnet ef
You must install or update .NET to run this application.

The following frameworks were found:
  6.0.25 at [C:\Program Files\dotnet\shared\Microsoft.NETCore.App]
  8.0.0 at [C:\Program Files\dotnet\shared\Microsoft.NETCore.App]


private string GenerateJwtToken()
        {
            var securityKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_configuration["Jwt:Key"]));
            var credentials = new SigningCredentials(securityKey, SecurityAlgorithms.HmacSha256);
            var sub = "BV0183202";
            var TIME_SPAN = 24;

            var claims = new[]
            {
                new Claim(JwtRegisteredClaimNames.Iat, DateTime.Now.ToString()),
                new Claim(JwtRegisteredClaimNames.Sub, sub),
                new Claim(JwtRegisteredClaimNames.Exp, TIME_SPAN.ToString()),
            };

            var token = new JwtSecurityToken(
                issuer: _configuration["Jwt:Issuer"],
                audience: _configuration["Jwt:Audience"],
                claims,
                expires: DateTime.Now.AddHours(TIME_SPAN),
                signingCredentials: credentials);

            return new JwtSecurityTokenHandler().WriteToken(token);
        }

The type or namespace name 'VisualStudio' does not exist in the namespace 'Microsoft' (are you missing an assembly reference?)

型または名前空間の名前 'AspNetCore' が名前空間 'Microsoft' に存在しません (アセンブリ参照があることを確認してください)
========== ビルド: 成功 0、失敗 1、最新の状態 0、スキップ 0 ==========

The type or namespace name 'VisualStudio' does not exist in the namespace 'Microsoft' (are you missing an assembly reference?)



using System.Net;
using System.Net.Http;
using System.Text.Json.Serialization;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization.Infrastructure;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace Test.CsrfControllerTests;

[TestClass]
public class CsrfControllerTests
{
    private readonly HttpClient _client;

    public CsrfControllerTests()
    {
        _client = new HttpClient();
        _client.BaseAddress = new System.Uri("http://localhost:8080");
    }
    [TestMethod]
    public async Task TestCsrfTokenEndpoint()
    {
        //Postリクエスト
        var request = new HttpRequestMessage(HttpMethod.Post, "/api/sys/csrf-token");
        request.Headers.Add("Accept", "application/json");
        request.Content = new StringContent("", System.Text.Encoding.UTF8, "application/json");

        //Send the request
        var response = await _client.SendAsync(request);

        //レスポンスアサーション
        Assert.AreEqual(HttpStatusCode.OK, response.StatusCode);

        //JSON Response 読み取り
        var jsonContent = await response.Content.ReadAsStringAsync();
        Assert.IsTrue(!string.IsNullOrWhiteSpace(jsonContent));

        //レスポンスをオブジェクトにする
        var csrfTokenResponse = JsonConverter.DeserializeObject<CsrfTokenResponse>(jsonContent);

        //アサーション
        AssertionRequirement.Equals("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOiIxNzA1NDc0OTY5Iiwic3ViIjoiQlYwMTgzMjAyIiwiZXhwIjoxNzA1NTYxMzY5LCJpc3MiOiJodHRwOi8vbG9jYWxob3N0OjgwODAiLCJhdWQiOiJodHRwOi8vbG9jYWxob3N0OjgwODAifQ.AMPAjhetXYMqaE2tRf7kmwBCt-_bgIb-AtGBW72uf9I", csrfTokenResponse.CsrfToken);
    }
}




<Project Sdk="Microsoft.NET.Sdk.Web">

  <PropertyGroup>
    <TargetFramework>net8.0</TargetFramework>
    <Nullable>enable</Nullable>
    <ImplicitUsings>enable</ImplicitUsings>
    <InvariantGlobalization>true</InvariantGlobalization>
  </PropertyGroup>

  <ItemGroup>
    <PackageReference Include="Microsoft.AspNetCore.Authentication.JwtBearer" Version="8.0.0" />
    <PackageReference Include="Microsoft.AspNetCore.OpenApi" Version="8.0.0" />
    <PackageReference Include="Microsoft.EntityFrameworkCore.Tools" Version="8.0.1">
      <IncludeAssets>runtime; build; native; contentfiles; analyzers; buildtransitive</IncludeAssets>
      <PrivateAssets>all</PrivateAssets>
    </PackageReference>
    <PackageReference Include="Swashbuckle.AspNetCore" Version="6.4.0" />
  </ItemGroup>

</Project>
